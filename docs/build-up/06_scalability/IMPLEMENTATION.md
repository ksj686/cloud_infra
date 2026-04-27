# Implementation Guide: Phase 6 Scalability

본 문서는 Phase 6 IaC 기반 확장 및 고가용성 클러스터 구성을 위한 상세 명령어 및 설정 파일 명세 정리

---

## 1. 코드형 인프라 (IaC)

### 1.1 Terraform을 이용한 VM 프로비저닝

```hcl
# main.tf
resource "proxmox_vm_qemu" "infra_nodes" {
  count       = 3
  name        = "node-0${count.index + 1}"
  target_node = "pve-01"
  clone       = "ubuntu-2404-template"

  cores   = 2
  memory  = 4096

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }
}
```

```bash
# 실행 절차
terraform init
terraform plan
terraform apply -auto-approve
```

### 1.2 Ansible 구성 관리

```bash
# 인벤토리 설정 (hosts.ini)
[db_nodes]
192.168.100.11
192.168.100.12
192.168.100.13

# 플레이북 실행 (OS 하드닝 등)
ansible-playbook -i hosts.ini site.yml
```

---

## 2. DB 고가용성 클러스터 (Galera)

### 2.1 MariaDB Galera Cluster 설정

```yaml
# /etc/mysql/mariadb.conf.d/60-galera.cnf
[galera]
wsrep_on=ON
wsrep_provider=/usr/lib/galera/libgalera_smm.so
wsrep_cluster_address="gcomm://192.168.100.11,192.168.100.12,192.168.100.13"
binlog_format=row
default_storage_engine=InnoDB
```

```bash
# 첫 번째 노드 부트스트랩 (Leader)
sudo galera_new_cluster

# 나머지 노드 재시작
sudo systemctl restart mariadb
```

---

## 3. ProxySQL 부하 분산

### 3.1 무중단 롤링 업데이트 (Rolling Update)

```yaml
# docker-compose.yml 내 업데이트 전략
deploy:
  replicas: 3
  update_config:
    parallelism: 1
    delay: 10s
    order: start-first
    failure_action: rollback
  healthcheck:
    test: ["CMD", "curl", "-f", "http://localhost/health"]
    interval: 30s
```

```bash
# 업데이트 수행 (이미지 버전 업그레이드 시)
docker stack deploy -c docker-compose.yml infra_stack
```

---

## 4. 온프레미스 네트워크 서비스 (MetalLB)

클라우드 외부 로드밸런서 연동 없이 공인/사설 IP 할당을 위한 LB 구축

### 4.1 MetalLB 설치 및 L2 모드 설정

```bash
# kube-proxy 설정 수정 (strictARP 활성화)
kubectl edit configmap -n kube-system kube-proxy
# strictARP: true 로 변경 확인

# MetalLB 네이티브 매니페스트 적용
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.12/config/manifests/metallb-native.yaml
```

### 4.2 IP 주소 풀(Pool) 정의

```yaml
# metallb-config.yaml
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: default-pool
  namespace: metallb-system
spec:
  addresses:
    - 192.168.100.200-192.168.100.250 # 가용 IP 대역 지정
---
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: default-adv
  namespace: metallb-system
```

---

## 5. 설정 변경 자동 동기화 (Hot-reload)

### 5.1 Reloader 오퍼레이터 설치 (추천)

```bash
# Helm을 이용한 Reloader 설치
helm repo add stakater https://stakater.github.io/stakater-charts
helm repo update
helm install reloader stakater/reloader --namespace config-management --create-namespace
```

### 5.2 Helm 내장 SHA256 자동화 (매니페스트 예시)

```yaml
# templates/deployment.yaml
spec:
  template:
    metadata:
      annotations:
        # ConfigMap 변경 시 자동으로 해시를 계산하여 파드 재시작 유도
        checksum/config:
          {
            {
              include (print $.Template.BasePath "/configmap.yaml") . | sha256sum,
            },
          }
```

---

## 6. K8s 설정 및 배포 자동화 (Helm & Argo CD)

### 4.1 Helm Chart 구조화

```bash
# Helm 차트 생성
helm create infra-app

# values.yaml 환경별 변수 정의
vi infra-app/values.yaml
```

```yaml
# infra-app/values.yaml 예시
replicaCount: 3
image:
  repository: hub.kosa.kr/library/infra-api
  tag: "1.0"
service:
  type: ClusterIP
  port: 80
```

### 4.2 Argo CD GitOps 어플리케이션 등록

```yaml
# argo-app.yaml (Argo CD에 등록할 매니페스트)
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: cloud-infra-app
  namespace: argocd
spec:
  project: default
  source:
    repoURL: "https://github.com/your-repo/cloud-infra.git"
    targetRevision: HEAD
    path: charts/infra-app
    helm:
      valueFiles:
        - values.yaml
  destination:
    server: "https://kubernetes.default.svc"
    namespace: prod
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

```bash
# Argo CD에 어플리케이션 생성
kubectl apply -f argo-app.yaml
```

---

## 5. 지능형 스케일링 (KEDA)

### 4.1 이벤트 기반 오토스케일링 설정

```yaml
# keda-scaledobject.yaml
apiVersion: keda.sh/v1alpha1
kind: ScaledObject
metadata:
  name: api-scaler
spec:
  scaleTargetRef:
    name: api-deployment
  triggers:
    - type: prometheus
      metadata:
        serverAddress: http://thanos-query:9090
        metricName: http_requests_total
        threshold: "100"
        query: sum(rate(http_requests_total{job="api"}[1m]))
```

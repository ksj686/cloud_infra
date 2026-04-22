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

## 4. 지능형 스케일링 (KEDA)

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

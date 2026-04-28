# [Step 7-5] Istio 서비스 메시 및 Sidecar 주입 실습

**목표:** Istio 서비스 메시를 설치하고, 애플리케이션 파드에 Sidecar 컨테이너를 자동으로 주입하여 트래픽 관측성 및 보안성을 확보함.

---

## 1. 개요 및 필요성

- **Sidecar 패턴:** 메인 컨테이너 옆에 보조 컨테이너를 배치하여 로깅, 보안, 네트워크 제어 기능을 대행함.
- **Istio Proxy (Envoy):** 모든 인입/인출 트래픽을 가로채서 통제하는 고성능 프록시 Sidecar.

---

## 2. 실습 절차

### 2.1 Istio 설치 (istioctl 활용)

```bash
# Istio 다운로드 및 경로 설정
curl -L https://istio.io/downloadIstio | sh -
cd istio-*
export PATH=$PWD/bin:$PATH

# 데모 프로파일로 설치
istioctl install --set profile=demo -y
```

### 2.2 네임스페이스 레이블 설정 (자동 주입 활성화)

특정 네임스페이스에 배포되는 모든 파드에 Sidecar가 자동 주입되도록 설정함.

```bash
# default 네임스페이스에 istio-injection 활성화
kubectl label namespace default istio-injection=enabled
```

### 2.3 샘플 앱 배포 및 Sidecar 확인

```bash
# 샘플 앱 배포
kubectl apply -f sidecar_injection_example.yaml

# 파드 상세 조회를 통해 컨테이너 개수(2/2) 확인
kubectl get pods
```

---

## 3. 관측성 및 보안 검증

- **Kiali 대시보드:** 서비스 간 호출 그래프 및 트래픽 흐름 시각화 확인함.
- **mTLS 확인:** 서비스 간 통신이 자동으로 암호화(Mutual TLS)되는지 정책 확인함.

---

## 4. 학습 포인트

- **관심사 분리:** 개발자가 네트워크/보안 로직을 코드에 짤 필요 없이 인프라 레벨에서 해결 가능함을 체득함.
- **운영 복잡도:** Sidecar 도입에 따른 리소스 오버헤드 및 관리 포인트 증가를 이해함.

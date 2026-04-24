# K8s 설정 관리 및 재배포 전략 (Helm & GitOps)

본 문서는 선언적 인프라 관리 및 무중단 배포를 위해 Helm Chart와 GitOps(Argo CD)를 연동하는 표준 운영 전략 정리

---

## 1. 선언적 패키지 관리 (Helm Chart)

- **템플릿화:** 중복되는 K8s 매니페스트를 구조화하여 재사용성 확보.
- **환경 분리:** `values-dev.yaml`, `values-prod.yaml` 등 파일 분리를 통해 동일 차트로 다중 환경 지원.
- **버전 관리:** 차트 버전을 통해 애플리케이션과 설정의 동시 롤백 기능 제공.

---

## 2. GitOps 기반 자동 배포 (Argo CD)

- **신뢰의 단일 원천 (Source of Truth):** Git 저장소의 상태를 클러스터의 최종 상태로 정의.
- **드리프트 탐지 (Drift Detection):** 수동 수정으로 인한 클러스터 상태 불일치를 자동으로 감지하고 Git 상태로 강제 동기화.
- **워크플로우:**
  1. 개발자/운영자가 Git에 `values.yaml` 수정 및 커밋.
  2. Argo CD가 변경 감지 및 자동 동기화(Sync) 수행.
  3. 클러스터 내 Helm 릴리즈 업데이트 완료.

---

## 3. 재배포 및 롤링 업데이트 전략

- **무중단 보장:** `RollingUpdate` 전략을 기본으로 하며, Argo CD의 `Health Check` 연동을 통해 배포 성공 여부 판단.
- **카나리(Canary) / 블루그린(Blue-Green):** 고난도 배포 시나리오 필요 시 Argo Rollouts 도입을 통한 리스크 최소화.

---

## 4. 도입 로드맵 (Adoption Roadmap)

1. **1단계 (기초):** 생 YAML 기반 `kubectl apply` 운영 (현재 Phase 6 초기).
2. **2단계 (표준화):** 핵심 서비스 Helm Chart 전환 및 변수 관리.
3. **3단계 (자동화):** Argo CD 설치 및 GitOps 파이프라인 연동.

### 🚀 [TO-BE] 차세대 고도화 과제

4. **4단계 (심화 - Istio Sidecar):**
   - **목적:** 서비스 메시 도입을 통한 정밀 트래픽 제어 및 전 구간 보안(mTLS) 강화.
   - **실습 안내:** [Step 7-5: Istio Sidecar 주입 실습](../../to-do-space/step7_cloud_native_ai/05_istio_sidecar/README.md) 참조.

---

## 5. 결론 및 제언

- Helm과 GitOps의 결합은 **'인프라 운영의 현대화'**를 상징하는 핵심 조합임.
- 초기 구축 복잡도는 상승하나, 장기적인 유지보수 및 협업 관점에서 필수적인 선택임.

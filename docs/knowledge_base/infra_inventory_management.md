# 엔터프라이즈 인프라 자산 관리 전략 (Asset Management)

본 문서는 실제 운영 환경에서 IP, 호스트명, 설정값 등 인프라 자산을 체계적으로 관리하기 위한 방법론과 최신 기술 트렌드 정리

---

## 1. 개요 및 도전 과제 (Overview)

- **드리프트(Drift) 현상:** 문서에 기록된 정보와 실제 가동 중인 인프라 상태가 불일치하는 현상
- **데이터 파편화:** 자산 정보가 엑셀, 위키, 코드 등에 흩어져 있어 신뢰할 수 있는 단일 원천 부재
- **목표:** '신뢰할 수 있는 단일 원천(Source of Truth)' 확보 및 자동화 도구와의 연동성 극대화

---

## 2. 관리 방식의 진화 단계 (Evolution)

### 2.1 전통적 방식 (Conventional)

- **도구:** Excel, Confluence, Wiki
- **특징:** 수동 업데이트 중심의 정적 관리
- **한계:** 동시 수정이 어렵고 실시간 현행화가 보장되지 않으며, 자동화 도구(Terraform, Ansible)와의 데이터 연동 불가능

### 2.2 전문가 추천 방식: IPAM 및 DCIM 활용 (Best Practice)

- **핵심 도구:** **NetBox**
- **기술적 가치:**
  - **API First:** 모든 자산 정보를 API로 제공하여 인프라 자동화 공정의 데이터 소스로 활용
  - **가시성:** 데이터센터 랙(Rack) 구조, 케이블링, IP 대역(IPAM), 가상화 자원을 계층적으로 관리
  - **강제성:** 중복 IP 할당 방지 및 표준화된 호스트명 명명 규칙 적용 가능

### 2.3 최신 트렌드: 데이터 기반 운영 (Latest Trend)

- **GitOps 기반 자산 관리:** 모든 자산 명세를 YAML/JSON 형태로 Git에 저장하고, CI/CD 파이프라인을 통해 인프라 상태 강제 동기화
- **Dynamic Inventory:** 특정 값을 고정하지 않고 하이퍼바이저나 클라우드 API를 통해 실시간 할당 정보를 쿼리(Query)하여 가져오는 방식
- **Secret Orchestration:** IPAM 데이터와 HashiCorp Vault 등 비밀번호 관리 도구를 연동하여 보안 자산의 생명주기 통합 관리

---

## 3. 실무 적용 가이드라인 (Implementation Guide)

### 3.1 정보 분류 및 관리 원칙

- **일반 정보 (Static):** IP, 호스트명, 역할(Role), 담당자 등 -> **IPAM(NetBox)** 또는 **Git Data**로 관리
- **민감 정보 (Secret):** 패스워드, 인증서 키, API 토큰 등 -> **Vault** 또는 **Cloud Secret Manager** 사용 필수
- **동적 정보 (Runtime):** CPU/Memory 사용량, 활성 프로세스 등 -> **Observability(Prometheus)** 영역에서 처리

### 3.2 자동화 연동 시나리오

1. **정의:** NetBox UI 또는 Git YAML 파일에 신규 서버 정보 등록
2. **트리거:** Git Commit 또는 API Webhook 발생
3. **실행:** Ansible/Terraform이 등록된 데이터를 읽어와서 실제 서버 프로비저닝 수행
4. **검증:** 구축 완료 후 실제 할당 상태를 다시 자산 관리 도구에 피드백(Feedback)하여 무결성 확보

---

## 4. 결론 및 제언

- 엔터프라이즈 인프라의 성숙도는 **'얼마나 정확한 자산 데이터를 보유하고 있는가'**에 의해 결정됨
- 본 프로젝트의 `INFRA_INVENTORY.md`는 과도기적 단계이며, 대규모 확장 시 **NetBox**와 같은 전문 도구로의 이관 및 IaC 연동을 강력히 권장함

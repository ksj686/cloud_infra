# Project Implementation Workflow & Task Log

본 문서는 프로젝트의 전체 아키텍처 구축 공정 및 대화 기반 의사결정 사항을 추적하는 전략 문서

---

## 1. 현재 진행 상황 (Current Progress)

인프라 관리 체계 구축 완료 및 단계별 기술 실습(Roadmap) 착수 단계

- **[완료] 문서 작성 원칙 수립:** 순수 명사형 종결 및 기술적 정교함 원칙 정의 (`GEMINI.md`)
- **[완료] 기술 지식 베이스 구축:** 엔터프라이즈 HA 및 관측성 분석 완료 (`docs/knowledge_base/`)
- **[완료] 웹 포털 인프라 구축:** MkDocs Material 기반 환경 설정 및 빌드 검증 완료
- **[완료] 개발 환경 표준화:** uv, nvm 도입 및 지침 수립 (`docs/ENVIRONMENT_SETUP.md`)
- **[진행 중] 실습 로드맵 이행:** Step 1 기초 자동화 실습 착수 및 가이드 작성 중

---

## 2. 단기 실행 과제 (Immediate Actions)

로드맵의 기초 단계(Step 1-3) 완수 및 웹 포털 안정화

1. **Step 1 실습 수행:** 크론탭 알림, 백업, 모니터링 등 운영 기초 자동화 구현
2. **Step 2-3 준비:** 트러블슈팅 및 시스템 운영 최적화 시나리오 검토
3. **형상 관리:** 각 실습 단계 완료 시 에이전트 제안 전략에 따른 분할 커밋 수행

---

## 3. 중장기 기술 구현 과제 (Technical Roadmap)

로드맵(Step 6-7)에 명시된 핵심 엔터프라이즈 기술의 구현 계획

### 3.1 Step 6: 엔터프라이즈 고가용성 DB 환경

- **과업:** 직접 구성 방식의 Galera Cluster + ProxySQL 아키텍처 구현
- **상세 내역:**
  - Proxmox 내 3개 노드 VM 프로비저닝 (Terraform 활용 검토)
  - MariaDB Galera Cluster 기반 동기식 복제 구성
  - `garbd`를 이용한 쿼럼 유지 및 비용 최적화 실습
  - ProxySQL을 통한 Read/Write 분할 및 장애 조치(Failover) 테스트
- **대기 상태:** 아키텍처 설계 및 가이드 작성 완료. 기초 실습(Step 1-5) 완료 후 착수 예정

### 3.2 Step 7: 클라우드 네이티브 및 AI 관측성

- **과업:** Thanos 기반 멀티 클러스터 통합 모니터링 및 AI 부하 예측 도입
- **상세 내역:**
  - Thanos Receiver/Query 아키텍처 구현
  - k6를 이용한 p95 지연 시간 정밀 성능 분석
  - MS AI 모델 연동을 통한 선제적 오토스케일링(KEDA) 체계 검증

---

## 4. 아키텍처 의사결정 기록 (ADR)

본 프로젝트의 모든 주요 기술적 의사결정은 `docs/decisions/` 디렉토리에 **ADR (Architecture Decision Records)** 형식으로 관리함.

- **전체 이력 확인:** [ADR Index (README.md)](decisions/README.md)
- **최신 주요 결정:**
  - [ADR-007: HA 계층형 가용성 전략 채택](decisions/ADR-007-ha-layered-strategy.md)
  - [ADR-006: 태스크 관리 도구 확장 전략](decisions/ADR-006-task-management-strategy.md)
  - [ADR-005: pre-commit 프레임워크 전면 도입](decisions/ADR-005-quality-automation.md)

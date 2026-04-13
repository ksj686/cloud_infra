# Architecture Decision Records (ADR)

본 디렉토리는 `cloud_infra` 프로젝트의 주요 아키텍처 의사결정 이력을 추적하며, 각 결정의 배경(Context), 선택(Decision), 및 결과(Consequences)를 불변의 기록으로 관리함.

## 📋 ADR Index

| 번호        | 결정 사항                                                                           | 날짜       | 상태        |
| :---------- | :---------------------------------------------------------------------------------- | :--------- | :---------- |
| **ADR-001** | [DB 구축 방식: Self-managed 채택](ADR-001-db-setup-method.md)                       | 2026-03-31 | ✅ Accepted |
| **ADR-002** | [문서화 도구: MkDocs Material 도입](ADR-002-documentation-tool.md)                  | 2026-03-31 | ✅ Accepted |
| **ADR-003** | [소스 관리: 분석용 소스 경로 최적화](ADR-003-source-management-strategy.md)         | 2026-04-01 | ✅ Accepted |
| **ADR-004** | [데이터 보존: 호스트 바인드 마운트 원칙](ADR-004-data-persistence-strategy.md)      | 2026-04-06 | ✅ Accepted |
| **ADR-005** | [품질 관리: pre-commit 프레임워크 전면 도입](ADR-005-quality-automation.md)         | 2026-04-07 | ✅ Accepted |
| **ADR-006** | [태스크 관리: 단계별 도구 확장 전략](ADR-006-task-management-strategy.md)           | 2026-04-08 | ✅ Accepted |
| **ADR-007** | [HA 전략: 계층형 가용성(Layered Availability) 채택](ADR-007-ha-layered-strategy.md) | 2026-04-13 | ✅ Accepted |

---

## ADR 작성 가이드

- **Status:** Proposed / Accepted / Superceded (대체됨)
- **Context:** 왜 이 결정이 필요했는가 (배경)
- **Decision:** 어떤 결정을 내렸는가
- **Consequences:** 이 결정으로 인해 얻는 이득과 감수해야 할 비용

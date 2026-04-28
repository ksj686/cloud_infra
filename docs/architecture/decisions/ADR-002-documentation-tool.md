# ADR-002: 문서화 도구: MkDocs Material 도입

- **Status:** ✅ Accepted
- **Date:** 2026-03-31
- **Decider:** Gemini CLI & User

## Context (배경)

- 프로젝트의 아키텍처, 트러블슈팅 이력, 실습 가이드를 체계적으로 자산화할 플랫폼이 필요함.
- 코드와 문서의 이격(Drift)을 방지하기 위해 'Docs as Code' 원칙을 준수해야 함.

## Alternatives Considered (대안 분석)

1. **Wiki (Notion, Confluence):** 사용은 편리하나 Git 기반의 버전 관리와 통합이 어렵고, 오프라인 접근성이 떨어짐.
2. **Static Site Generators (Hugo, Jekyll):** 성능은 우수하나 설정이 복잡하고 엔지니어링 문서 특유의 '검색 및 기술 가이드' UI를 구성하는 데 공수가 많이 듦.

## Decision (결정)

- **MkDocs**와 **Material for MkDocs** 테마를 채택함.
- **이유:** 마크다운(Markdown) 기반의 단순함, 강력한 로컬 검색 엔진, 그리고 엔지니어링 문서에 최적화된 UI(Admonitions, Code Blocks 등)를 제공함.

## Consequences (결과)

- **이득:**
  - Git Flow와 연동된 문서 업데이트 체계 구축 가능 (Docs as Code).
  - 테마 내장 기능(Grid UI, Tabbed blocks)을 통한 시각적 정보 전달력 향상.
- **비용:** 로컬 빌드를 위한 Python 환경 유지 및 `mkdocs.yml` 설정 관리가 필요함.

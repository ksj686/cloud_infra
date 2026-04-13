# ADR-002: 문서화 도구: MkDocs Material 도입

- **Status:** ✅ Accepted
- **Date:** 2026-03-31
- **Decider:** Gemini CLI & User

## Context (배경)

- 프로젝트의 진행 상황, 설계도, 실습 가이드를 효율적으로 공유하고 관리할 시각적인 문서 플랫폼이 필요함.
- 엔지니어링 중심의 깔끔한 디자인과 마크다운(Markdown) 기반의 편집 편의성이 중요함.

## Decision (결정)

- **MkDocs**와 **Material for MkDocs** 테마를 프로젝트 표준 문서화 도구로 채택함.
- 검색 기능, 태그, 카드 그리드 UI 등을 적극 활용하여 가독성을 극대화함.

## Consequences (결과)

- **이득:** 정적 사이트 생성을 통해 문서 검색 및 접근성이 향상되며, 엔지니어링 톤앤매너 유지 가능.
- **비용:** 로컬 빌드 환경(Python, mkdocs) 구축 및 설정 관리 필요.

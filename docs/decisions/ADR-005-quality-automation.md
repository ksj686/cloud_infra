# ADR-005: 품질 관리: pre-commit 프레임워크 전면 도입

- **Status:** ✅ Accepted
- **Date:** 2026-04-07
- **Decider:** Gemini CLI & User

## Context (배경)

- 프로젝트 규모가 커짐에 따라 코드/문서 포맷팅의 불일치 및 시크릿(API Key 등) 유출 위험이 증가함.
- 수동 점검에 의존하는 품질 관리는 한계가 있음.

## Decision (결정)

- **`pre-commit`** 프레임워크를 전면 도입하여 Git 커밋 직전에 자동 검사를 수행함.
- **주요 훅(Hooks):** Prettier(포맷팅), ShellCheck(쉘 스크립트 진단), Gitleaks(시크릿 스캔).

## Consequences (결과)

- **이득:** 일관된 코드 스타일 유지 및 보안 사고 예방 자동화.
- **비용:** 최초 환경 설정(Python, pre-commit install) 과정이 추가되며, 규칙 위반 시 커밋이 차단됨.

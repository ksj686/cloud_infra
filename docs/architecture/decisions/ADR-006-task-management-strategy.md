# ADR-006: 태스크 관리: 단계별 도구 확장 전략

- **Status:** ✅ Accepted
- **Date:** 2026-04-08
- **Decider:** Gemini CLI & User

## Context (배경)

- Windows(PowerShell), Mac/Linux(Bash) 등 **다양한 OS 환경에서의 관리 효율성**을 동시에 확보해야 함.
- 초기부터 특정 언어에 종속된 빌드 도구(npm, poe 등)를 강제하기보다, 환경별 네이티브한 접근이 필요함.

## Decision (결정)

- **도구 에스컬레이션(Tool Escalation)** 전략 채택:
  - **1단계 (현재):** OS별 전용 스크립트(`gen-pdf.ps1`, `gen-pdf.sh`)를 사용하여 즉각적인 실행 속도와 호환성 확보.
  - **2단계 (중기):** 파이썬 명령어 캡슐화를 위해 `poethepoet` 도입 검토.
  - **3단계 (장기):** 복합 언어 환경 도달 시 `pnpm scripts`로 통합 관리.

## Consequences (결과)

- **이득:** 각 OS 환경에서 별도의 런타임 설치 없이도 즉시 자동화 스크립트 실행 가능.
- **비용:** 동일 로직을 두 언어(PS, Bash)로 중복 관리해야 하는 유지보수 부담 존재.

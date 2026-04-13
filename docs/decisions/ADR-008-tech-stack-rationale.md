# ADR-008: 런타임 및 의존성 관리 도구 선정 (nvm, pyenv, pnpm, poetry)

- **Status:** ✅ Accepted
- **Date:** 2026-04-13
- **Decider:** Gemini CLI & User

## Context (배경)

- 프로젝트 규모 확장에 따른 언어/라이브러리 버전 충돌 방지 및 **유령 의존성(Phantom Dependency)** 차단이 필수적임.
- **라이선스 리스크:** Conda(Anaconda)는 기업 환경(200인 이상)에서 유료 청구 대상이 될 수 있어 법적 안전성 확보가 필요함.
- **신뢰성:** Conda의 무료 채널(`conda-forge` 등)은 때때로 해결 불가능한 의존성 문제를 야기하여 빌드 안정성을 저해함.

## Decision (결정)

1. **런타임:** `nvm` 및 `pyenv`를 통한 프로젝트별 환경 격리.
2. **Node.js:** 호이스팅 문제를 차단하여 의존성 관리가 더 철저한 `pnpm` 채택.
3. **Python:** Conda의 유료화 리스크와 의존성 해결 불안정성을 피하기 위해, 가장 강력한 리졸버를 가진 **`Poetry`**를 표준으로 선정.

## Consequences (결과)

- **이득:**
  - 기업 환경에서도 법적/비용적 리스크 없는 안전한 기술 스택 운용.
  - `poetry.lock` 및 `pnpm-lock.yaml`을 통한 완벽한 환경 재현성 확보.
- **비용:** Conda 환경 대비 바이너리 설치 편의성은 다소 낮으나, 시스템 안정성은 획기적으로 향상됨.

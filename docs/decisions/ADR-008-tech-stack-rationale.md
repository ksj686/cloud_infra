# ADR-008: 런타임 및 의존성 관리 도구 선정 (nvm, pyenv, pnpm, poetry)

- **Status:** ✅ Accepted
- **Date:** 2026-04-13
- **Decider:** Gemini CLI & User

## Context (배경)

- 프로젝트 규모가 커짐에 따라 다양한 언어(Python, Node.js)와 라이브러리의 버전 충돌을 방지해야 함.
- **의존성 무결성(Dependency Integrity):** 직접 선언하지 않은 패키지가 사용되는 '유령 의존성' 문제를 차단해야 함.
- **라이선스 컴플라이언스(License Compliance):** 기업 환경에서도 법적/비용적 리스크 없이 지속 가능한 도구를 선정해야 함.

## Decision (결정)

### 1. 런타임 관리: nvm(Node.js) & pyenv(Python)

- 시스템 전역 설정을 오염시키지 않고 프로젝트별 독립된 런타임 버전 사용.

### 2. Node.js 패키지 관리: pnpm

- **엄격한 관리:** npm의 '호이스팅' 방식에 의한 유령 의존성(Phantom Dependency) 문제를 구조적으로 차단.
- **효율성:** 콘텐츠 주소 지정 저장소 방식을 통한 디스크 절약 및 설치 속도 극대화.

### 3. Python 의존성 관리: Poetry (Conda 및 Pipenv 대비 우위)

- **라이선스 안전성:** 기업 환경에서 유료화 리스크가 있는 `Conda`를 배제한 순수 오픈소스 표준.
- **결정론적 빌드:** `poetry.lock`을 통해 패키지 간 의존성 그래프를 완벽히 고정하여 환경 재현성 보장.
- **도구 통합:** 가상환경 관리(`venv`), 패키징(`setup.py`), 의존성 선언(`requirements.txt`)의 파편화된 도구 체계를 `pyproject.toml` 하나로 통합하여 운영 효율성 증대.
- **성숙도 기반 선정:** `Pipenv`의 성능 이슈와 `PDM`/`uv`의 생태계 성숙도 문제를 고려할 때, 현재 엔터프라이즈 환경에서 가장 신뢰할 수 있는 대안으로 판단.

## Consequences (결과)

- **이득:**
  - 유령 의존성 차단을 통한 런타임 예측 가능성 향상.
  - 기업 환경에서도 추가 비용이나 라이선스 위반 걱정 없는 안전한 인프라 구성.
  - 명확한 의존성 해결(Dependency Resolution)을 통한 '지옥의 의존성(Dependency Hell)' 방지.
- **비용:**
  - 각 도구(pnpm, poetry)에 대한 초기 학습 곡선 존재.
  - 기존 `requirements.txt` 기반 환경에서의 마이그레이션 공수 발생.

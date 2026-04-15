# Git Hook 기반 협업 자동화 가이드 (Husky)

본 문서는 팀 프로젝트 시 환경 불일치를 해소하기 위해 Git Hook(특히 `post-merge`)을 활용한 의존성 자동 동기화 체계 및 설정 방법 정리

---

## 1. 개요 및 목적 (Overview)

- **문제점:** 동료가 추가한 신규 패키지가 포함된 코드를 `pull` 받은 후, 로컬 설치 명령(`pnpm install`, `uv sync`) 수행을 망각하여 발생하는 빌드 에러 방지
- **해결책:** Git의 `merge` 이벤트 종료 후 실행되는 `post-merge` 훅을 통해 락파일 변경 시 설치 명령 자동화 수행
- **공유 메커니즘:** 로컬 전용 훅(`.git/hooks`)의 한계를 극복하기 위해 `Husky`를 사용하여 팀 전체에 자동화 스크립트 공유 및 강제 적용

---

## 2. Husky 설치 및 초기화

팀 공통 Git Hook 관리 도구 도입 절차

- **설치 명령어:**
  ```powershell
  pnpm add -D husky
  ```
- **환경 초기화:**
  ```powershell
  pnpm exec husky init
  ```
- **결과:** 프로젝트 루트에 `.husky/` 폴더 생성 및 Git 추적 시작

---

## 3. 통합 의존성 자동 동기화 스크립트 (`post-merge`)

`git pull` 또는 `merge` 완료 시 락파일 변경을 감지하여 자동 설치 수행

### 3.1 스크립트 작성

`.husky/post-merge` 파일에 아래 내용 작성 및 실행 권한 부여

```bash
#!/bin/bash
# 변경된 파일 목록 추출 (병합 전후 비교)
changed_files="$(git diff-tree -r --name-only --no-commit-id ORIG_HEAD HEAD)"

# 1. Node.js 의존성 동기화 (pnpm-lock.yaml)
if echo "$changed_files" | grep -q "pnpm-lock.yaml"; then
  echo "📦 pnpm-lock.yaml 변경 감지 → pnpm install 수행 중..."
  pnpm install
fi

# 2. Python 의존성 동기화 (uv.lock)
if echo "$changed_files" | grep -q "uv.lock"; then
  echo "🐍 uv.lock 변경 감지 → uv sync 수행 중..."
  uv sync
fi
```

---

## 4. 관리 및 주의 사항

- **실행 권한:** 유닉스 계열 환경의 팀원을 위해 해당 파일에 실행 권한(`chmod +x`) 부여 필수
- **수동 수행 배제:** 본 설정 완료 후 팀원은 `git pull` 만으로 최신 개발 환경 상시 유지 가능
- **드리프트 방지:** 락파일이 프로젝트의 신뢰 원천(Source of Truth)으로 기능하도록 관리 원칙 준수

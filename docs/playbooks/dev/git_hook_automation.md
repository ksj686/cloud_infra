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

## 3. 통합 의존성 자동 동기화 설정 (Implementation)

`git pull` 또는 `merge` 완료 시 락파일 변경을 감지하여 자동 설치 수행

### 3.1 post-merge 훅 파일 생성

`.husky/post-merge` 파일을 생성하고 아래 스크립트 작성

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

### 3.2 실행 권한 및 불필요 파일 정리

윈도우 환경 대응 및 기존 샘플 파일 제거 절차

```powershell
# 1. 초기화 시 생성된 불필요 샘플 제거 (선택 사항)
Remove-Item .husky/pre-commit

# 2. Git 인덱스를 통한 실행 권한 강제 부여 (Cross-platform 대응)
git add .husky/post-merge
git update-index --chmod=+x .husky/post-merge
```

---

## 4. 팀 협업자 가이드 (For Team Members)

초기 설정자 외의 팀원이 프로젝트 참여 시 수행해야 할 최소 작업

### 4.1 초기 의존성 및 훅 활성화

저장소 `clone` 직후 1회만 수행하면 이후 모든 자동화 혜택 적용

```powershell
# 모든 패키지 설치 및 Husky 훅 활성화
pnpm install
uv sync

# pre-commit 훅 등록 (보안/품질용)
uv run pre-commit install
```

### 4.2 사후 관리

- **자동화 적용:** 이후 `git pull` 시 락파일 변경이 감지되면 별도 명령 없이 패키지가 자동 업데이트됨.
- **드리프트 방지:** 로컬에서 임의로 `post-merge` 파일을 수정하지 않으며, 수정 필요 시 공유용 브랜치를 통해 정식 반영 및 전파 수행.

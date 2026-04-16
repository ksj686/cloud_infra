# Poetry to uv Migration Guide

본 문서는 파이썬 패키지 및 환경 관리 도구를 Poetry에서 **`uv`**로 전환하기 위한 상세 마이그레이션 절차와 명령어 정리

---

## 1. 사전 준비 및 호스트 환경 정리 (Cleanup)

기존 도구의 전역 삭제를 통한 시스템 간섭 차단 및 리소스 확보

### 1.1 Poetry 전역 삭제 (Windows)

- **공식 언인스톨러 실행:**
  ```powershell
  (Invoke-WebRequest -Uri https://install.python-poetry.org -UseBasicParsing).Content | python - --uninstall
  ```
- **잔여 설정 및 캐시 폴더 수동 삭제:**
  - `%APPDATA%\pypoetry` (설정 데이터)
  - `%LOCALAPPDATA%\pypoetry` (캐시 및 가상환경)
  - **명령어:** `Remove-Item -Recurse -Force $env:APPDATA\pypoetry, $env:LOCALAPPDATA\pypoetry`

### 1.2 pyenv-win 전역 삭제 (PowerShell)

터미널에서 아래 스크립트를 실행하여 폴더 삭제 및 환경 변수 정리를 한 번에 수행합니다.

```powershell
# 1. 설치 폴더 제거
Remove-Item -Recurse -Force "$HOME\.pyenv"

# 2. 사용자 환경 변수(PYENV 관련) 완전 삭제
"PYENV", "PYENV_HOME", "PYENV_ROOT" | ForEach-Object {
    [System.Environment]::SetEnvironmentVariable($_, $null, "User")
}

# 3. Path 환경 변수에서 pyenv 관련 경로 제거
$oldPath = [System.Environment]::GetEnvironmentVariable("Path", "User")
$newPath = ($oldPath -split ';' | Where-Object { $_ -notmatch 'pyenv-win' }) -join ';'
[System.Environment]::SetEnvironmentVariable("Path", $newPath, "User")

Write-Host "pyenv-win 삭제 및 환경 변수 정리가 완료되었습니다. 터미널을 재시작하세요." -ForegroundColor Green
```

### 1.3 프로젝트 로컬 파일 정리

- **가상 환경 및 락파일 제거:**
  ```powershell
  Remove-Item -Recurse -Force .venv
  Remove-Item poetry.lock
  ```

---

## 2. uv 설치 및 프로젝트 전이 (Migration)

- **uv 설치 (Windows PowerShell):**
  ```powershell
  powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
  ```
- **환경 변수 적용 (필수):** 설치 완료 후, 새로운 `Path` 설정을 반영하기 위해 **현재 사용 중인 터미널(PowerShell) 또는 VS Code를 반드시 재시작**합니다.
- **설치 확인:** `uv --version`

---

## 2. 프로젝트 초기화 및 마이그레이션 (Core Process)

`pyproject.toml`을 유지하며 `uv` 체계로 전환

### 2.1 uv 환경 초기화

프로젝트 루트에서 `uv` 설정 파일 생성을 위해 수행 (기존 `pyproject.toml` 감지 시 자동 연동)

```powershell
uv init --no-workspace
```

### 2.2 의존성 동기화 및 uv.lock 생성

Poetry의 의존성 정보를 읽어 `uv` 전용 락파일 생성 및 가상 환경 재구축

```powershell
# pyproject.toml의 내용을 바탕으로 가상 환경 생성 및 동기화
uv sync
```

- **결과:** `uv.lock` 파일이 생성되며, 초고속 리졸버를 통한 의존성 해결 완료.

---

## 3. 주요 명령어 매핑 (Command Comparison)

Poetry 사용자가 숙지해야 할 `uv` 명령어 대응 표

| 기능               | Poetry 명령어                   | uv 명령어                                        |
| :----------------- | :------------------------------ | :----------------------------------------------- |
| **의존성 설치**    | `poetry install`                | `uv sync`                                        |
| **패키지 추가**    | `poetry add <name>`             | `uv add <name>`                                  |
| **개발 도구 추가** | `poetry add --group dev <name>` | `uv add --dev <name>`                            |
| **스크립트 실행**  | `poetry run <command>`          | `uv run <command>`                               |
| **가상 환경 진입** | `poetry shell`                  | `source .venv/bin/activate` (또는 `uv run` 활용) |
| **락파일 갱신**    | `poetry lock`                   | `uv lock`                                        |

---

## 4. 파이썬 버전 관리 (Python Management)

`pyenv` 기능을 대체하는 `uv` 고유 기능 활용

- **버전 명시:** `.python-version` 파일에 버전 기재 (예: `3.12.8`)
- **자동 설치:** `uv sync` 또는 `uv run` 실행 시 해당 버전이 없으면 `uv`가 직접 다운로드 및 적용
- **특정 버전 강제:**
  ```powershell
  uv python install 3.12.8
  uv python pin 3.12.8
  ```

---

## 5. 사후 정리 및 검증 (Verification)

전환 완료 후 시스템 무결성 확인

### 5.1 기존 Poetry 파일 제거

마이그레이션이 성공적으로 완료된 후 불필요한 파일 삭제

```powershell
# Poetry 전용 락파일 삭제
Remove-Item poetry.lock
```

### 5.2 도구 정상 작동 확인

기존 개발 도구들이 `uv` 환경에서 정상 동작하는지 테스트

```powershell
# pre-commit 작동 확인
uv run pre-commit run --all-files

# pip-audit 작동 확인
uv run pip-audit
```

---

## 6. 트러블슈팅 (Troubleshooting)

- **pip-audit 가상 환경 경고:** 윈도우에서 `uv run pip-audit` 실행 시 드라이브 문자 대소문자 인식 차이(`C:` vs `c:`)로 인해 환경 불일치 경고가 발생할 수 있습니다.
  - **현상:** `pip-audit will run pip against ... but you have a virtual environment loaded at ...`
  - **해결:** `uv run` 대신 `uvx`를 사용하면 독립된 환경에서 깨끗하게 실행됩니다.
    ```powershell
    uvx pip-audit
    ```
- **SSL 에러 (인증서 관련):** 기업망 내부에서 설치 스크립트 실행 실패 시 `--insecure` 옵션 검토 또는 사설 CA 등록 확인.
- **Path 인식 불가:** 설치 직후 `uv` 명령어가 인식되지 않을 경우, 터미널 재시작 또는 `$env:Path`에 `~/.cargo/bin` 추가 여부 확인.
- **인코딩 충돌:** Windows 환경에서 로그 확인 시 한글 깨짐 발생 시 `$env:PYTHONUTF8=1` 설정 후 실행.

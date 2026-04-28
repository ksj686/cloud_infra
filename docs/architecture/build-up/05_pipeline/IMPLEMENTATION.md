# Implementation Guide: Phase 5 Pipeline

본 문서는 Phase 5 보안 자동화 및 이미지 관리 체계 구성을 위한 상세 명령어 및 설정 파일 명세 정리

---

## 1. 고도화된 컨테이너 빌드 (Dockerfile)

### 1.1 Python 멀티 스테이지 빌드 예시

```dockerfile
# Stage 1: Builder
FROM python:3.12-slim AS builder
WORKDIR /app
COPY pyproject.toml uv.lock ./
RUN pip install uv && uv export --frozen --no-dev > requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Stage 2: Runtime
FROM python:3.12-slim
WORKDIR /app
RUN useradd -m appuser
COPY --from=builder /usr/local/lib/python3.12/site-packages /usr/local/lib/python3.12/site-packages
COPY . .
USER appuser
CMD ["python", "app.py"]
```

---

## 2. 기업형 이미지 관리 (Harbor)

### 2.1 Harbor CLI 로그인 및 취약점 스캔

```bash
# 레지스트리 로그인
docker login hub.kosa.kr -u admin -p "YourPassword"

# 이미지 태깅 및 푸시
docker tag my-app:latest hub.kosa.kr/library/my-app:v1.0
docker push hub.kosa.kr/library/my-app:v1.0

# Harbor UI에서 'Vulnerability Scanning' 활성화 확인
```

---

## 3. 로컬 및 CI 보안 가드레일

### 3.1 SAST (Semgrep) 정적 분석 실행

```bash
# Semgrep 설치 및 전체 검사
python3 -m pip install semgrep
semgrep scan --config auto
```

### 3.2 SCA (Software Composition Analysis) 종속성 감사

```bash
# Node.js 감사
pnpm audit

# Python 감사 (High 이상 발견 시 빌드 중단)
uv run pip-audit --fail-on-severity high
```

### 3.3 Trivy 이미지 정밀 스캔

```bash
# Trivy 설치 및 이미지 취약점 스캔
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
  aquasec/trivy:latest image hub.kosa.kr/library/my-app:v1.0
```

---

## 4. 자격 증명 보안 (Pass & GPG)

### 4.1 Docker Config 자동 업데이트 (Python 스크립트)

```python
# update_creds.py
import json, os

config_path = os.path.expanduser("~/.docker/config.json")
with open(config_path, "r") as f:
    data = json.load(f)

data["credsStore"] = "pass"

with open(config_path, "w") as f:
    json.dump(data, f, indent=2)
print("Docker Credential Helper 설정 완료.")
```

```bash
uv run python update_creds.py
```

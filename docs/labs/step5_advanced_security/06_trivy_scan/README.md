# [Step 5-6] Trivy를 활용한 컨테이너 이미지 보안 스캔

**목표:** Docker 이미지 내 포함된 OS 패키지 및 애플리케이션 라이브러리의 취약점을 점검함.

### 1. Trivy 설치 및 특징

- **범용성:** 이미지, 파일 시스템, IaC 설정(Terraform 등) 스캔 가능함.
- **설치:** `wget -qO - https://aquasecurity.github.io/trivy-repo/get_repo.sh | sudo bash && sudo apt install trivy -y`

### 2. 기본 사용법 (Image Scan)

- **특정 이미지 스캔:** `trivy image <image_name>:<tag>`
- **취약점 레벨 필터링:** `trivy image --severity HIGH,CRITICAL <image_name>`
- **예시:** `trivy image nginx:latest`

### 3. CI/CD 파이프라인 연동

- 빌드 완료된 이미지를 푸시하기 전 Trivy로 스캔함.
- `CRITICAL` 등급 취약점 발견 시 빌드 중단되도록 설정함.
- `trivy image --exit-code 1 --severity CRITICAL <image_name>`

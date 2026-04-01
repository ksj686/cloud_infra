# Playbook: 보안 자동화 파이프라인 (Security Pipeline)

## 📌 개요
- 개발 및 운영 전 과정에 보안 자동화 도구를 통합하여 취약점 조기 발견함.
- 로컬 커밋, CI 빌드, 아티팩트 생성 단계별 보안 무결성 검증함.

## ✅ 1단계: 로컬 보안 검증 (Phase 1: Local)
- **`pre-commit` & `Gitleaks` 설정**
    - 목적: 커밋 전 민감 정보 유출 차단 및 코드 품질 유지함.
    - 실행:
      ```bash
      # pre-commit 설치 및 설정
      pip install pre-commit
      pre-commit install
      
      # Gitleaks를 이용한 시크릿 스캔 (로컬)
      gitleaks detect --source . -v
      ```
- **코드 품질 분석**
    - `ESLint`(JS/TS), `Bandit`(Python) 등을 활용한 정적 분석 수행함.

## ✅ 2단계: 종속성 취약점 점검 (Phase 2: CI)
- **더미 웹서버 기반 SCA 스캔**
    - 목적: 사용 중인 오픈소스 라이브러리의 알려진 취약점 점검함.
    - 실행:
      ```bash
      # npm/pnpm audit을 통한 종속성 검사
      npm audit
      # 또는
      pnpm audit
      ```
- **정적 응용 프로그램 보안 테스트 (SAST)**
    - `Semgrep`을 활용한 커스텀 보안 규칙 검사 수행함.

## ✅ 3단계: 컨테이너 이미지 스캔 (Phase 3: Artifact)
- **`Trivy`를 이용한 이미지 취약점 분석**
    - 목적: Docker 이미지 내 OS 패키지 및 애플리케이션 취약점 탐지함.
    - 실행:
      ```bash
      # Docker 이미지 빌드 후 스캔
      trivy image [IMAGE_NAME]:[TAG]
      ```
- **취약점 등급 관리:** `CRITICAL`, `HIGH` 등급 발견 시 빌드 중단 및 수정 권고함.

## ✅ 4단계: 보안 이벤트 알림 (Phase 4: Alert)
- **실시간 알림 연동**
    - 파이프라인 실패 또는 보안 위협 감지 시 Slack Webhook을 통해 즉시 전송함.
    - 리포트 포함 사항: 도구명, 탐지된 취약점 수, 심각도 등.

---
*참조 문서: [README.md](../../README.md) 내 보안 도구 일람표*

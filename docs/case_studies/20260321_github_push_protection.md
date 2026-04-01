# Case Study: GitHub Push Protection 오탐지 및 보안 필터 대응

## 📌 1. 발생 상황 (Incident)
- **일시:** 2026년 3월 21일
- **현상:** `git push` 실행 중 GitHub 서버 측 보안 필터에 의해 푸시 거절됨.
- **에러 메시지:** `remote: error: GH013: Repository rule violations found for refs/heads/main.`
- **탐지 사유:** `GITHUB PUSH PROTECTION - Push cannot contain secrets` (Slack Incoming Webhook URL 탐지).

## 🔍 2. 원인 분석 (Root Cause)
- **보안 필터 작동:** GitHub 서버가 푸시되는 커밋 내의 민감 정보(API Key, Token 등)를 실시간 스캔함.
- **오탐지(False Positive):** 학습용으로 작성한 Slack Webhook URL 예시(`.../T00000000/B00000000/...`)가 실제 보안 토큰 패턴과 유사하여 보안 위협으로 간주됨.

## 🛠️ 3. 대응 과정 (Resolution)
- **1단계 (파일 수정):** `daily_report.sh` 및 `README.md` 내의 예시 URL을 기술적으로 유효하지 않은 추상적 형식(`REPLACE_WITH_YOUR_URL` 등)으로 변경함.
- **2단계 (커밋 수정):** 로컬에서 `git commit --amend`를 통해 마지막 커밋의 문제 소지 데이터를 제거함.
- **3단계 (보안 승인):** GitHub에서 제공한 전용 링크(`https://github.com/ksj686/cloud_infra/security/secret-scanning/unblock-secret/...`)를 통해 오탐지(False Positive)임을 승인함.
- **4단계 (최종 푸시):** 승인 후 재푸시를 통해 원격 저장소 반영 성공함.

## 💡 4. 교훈 및 재발 방지 (Lessons Learned)
- **문서화 원칙:** 실무 문서 작성 시 실제 서비스의 토큰 형식과 유사한 더미 데이터(Dummy Data) 사용 지양함.
- **사전 검증:** 로컬 개발 단계에서 `Gitleaks`와 같은 도구를 `pre-commit`에 연동하여 서버 푸시 전 미리 검증하는 체계 구축함.
- **보안 인지:** GitHub의 자동 보안 기능을 이해하고, 오탐지 발생 시 신속하게 승인 또는 수정할 수 있는 대응 프로세스 확보함.

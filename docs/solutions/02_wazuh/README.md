# Wazuh - 보안 위협 탐지 및 SIEM

엔드포인트 및 클라우드 환경 전반의 보안 가시성을 확보하기 위한 통합 보안 플랫폼.

### 1. 주요 기능 (XDR/SIEM Concepts)

- **Log Data Analysis**: 호스트 및 애플리케이션 로그 실시간 분석.
- **Vulnerability Detection**: 에이전트 설치 호스트의 취약점(CVE) 스캔.
- **File Integrity Monitoring (FIM)**: 중요 설정 파일의 변경 사항 감지.
- **Compliance Monitoring**: PCI DSS, HIPAA, NIST 규정 준수 확인.

### 2. 에이전트 설치 (Agent Installation - Ubuntu 기준)

1. Wazuh 대시보드에서 `Deploy new agent` 선택.
2. 운영체제 및 서버 IP 정보 입력 후 설치 스크립트 복사.
3. 대상 서버에서 스크립트 실행 및 에이전트 등록.
4. 서비스 시작: `systemctl start wazuh-agent`.

### 3. 탐지 규칙 관리 (Detection Rules)

- `rules/` 디렉토리에 커스텀 XML 규칙 작성.
- 특정 IP 차단, Brute-force 공격 탐지 등 인프라 특화 규칙 적용.
- 서버 보안 이벤트 실시간 알림 연동 (Email, Slack 등).

### 4. 인프라 실습 활용

- 비정상적인 SSH 접속 시도 자동 차단.
- 시스템 구성 파일의 임의 변경 실시간 추적.
- 컨테이너 환경의 런타임 보안 감시.

### 상업적 사용 (License)

- **Apache License 2.0**: 상업적으로 자유롭게 사용 가능.

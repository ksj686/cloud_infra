# HashiCorp Vault - 기밀 정보 관리
비밀번호, 토큰, 인증서 등 인프라의 민감한 정보를 안전하게 보관하고 제어.

### 1. 기본 원칙 (Secret Management Principles)
- **Keep Secrets Secret**: 모든 정보는 저장 시 암호화됨 (Encryption at rest).
- **Dynamic Secrets**: 요청 시 즉시 생성되고 사용 후 자동 소멸되는 비밀 번호.
- **Lease & Revocation**: 모든 비밀 정보는 유효 기간이 있으며 언제든 취소 가능.

### 2. 주요 인증 방식 (Auth Methods)
- **Token**: 기본 인증 방식, 다른 인증 성공 시 발급.
- **AppRole**: 애플리케이션 및 스크립트(CI/CD) 자동화 인증용.
- **LDAP / GitHub**: 사용자 계정 기반 인증 연동.
- **IAM (Cloud)**: AWS, Azure, GCP 등 클라우드 권한 기반 인증.

### 3. 접근 정책 (Policies)
- **Path-based RBAC**: 특정 경로에 대한 Read, Write, List 등 상세 권한 제어.
- `policies/` 디렉토리에 샘플 HCL 정책 파일 보관.

### 4. 인프라 보안 강화 실습
- **KV Store**: 정적인 환경 변수 및 설정 보안 저장.
- **DB Secrets Engine**: 데이터베이스 접속 계정 자동 생성 및 순환(Rotation).
- **Transit Engine**: 애플리케이션 데이터를 Vault를 통해 즉석 암호화.

### 상업적 사용 (License)
- **BSL (Business Source License)**: Community Edition은 일반 상업적 이용 가능 (상용 서비스 재판매 등의 경우 약관 확인 필요).

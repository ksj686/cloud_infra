---
marp: true
---

# 02. 다계층 보안 방어 체계 (Security Guardrails)

### 🛡️ Shift-Left 보안 전략

- **Gitleaks:** 시크릿 유출 자동 차단
- **ShellCheck:** 쉘 스크립트 문법 사전 진단
- **Prettier:** 일관된 스타일 및 문서 구조 강제

### 🔒 공급망 보안 및 감사

- **SCA (Dependency Audit):** 오픈소스 라이브러리 취약점 탐지
- **auditd:** 커널 레벨의 파일 변조 및 명령어 이력 추적

<!--
[발표자 스크립트]
두 번째 파트인 '보안 방어 체계'입니다.
우리는 'Shift-Left' 보안 전략을 채택하여, 보안 검증을 개발 초기 단계로 전진 배치했습니다.
'Gitleaks'로 민감 정보 유출을 막고, 'ShellCheck'와 'Prettier'로 코드의 질과 일관성을 유지합니다.
또한, 'auditd'를 통해 시스템 전반의 무결성을 보장하고 침입 이력을 실시간으로 추적합니다.
-->

# [Phase 5] Pipeline: 보안 자동화 및 이미지 관리

공급망 보안 강화 및 신뢰성 있는 배포 파이프라인 구축을 통한 인프라 변경 무결성 확보 절차 정리

---

## 1. 고도화된 컨테이너 빌드 전략 (Dockerfile Best Practices)

이미지 경량화 및 보안 강화를 위한 선진화된 빌드 패턴 적용

- **멀티 스테이지 빌드 (Multi-stage Build):**
  - **목적:** 빌드 의존성(JDK, Go SDK 등)을 최종 이미지에서 제거하여 공격 표면 최소화 및 용량 절감
  - **구조 예시:** `FROM golang AS builder` 단계에서 빌드 후, `FROM alpine` 단계로 결과물만 복사(`COPY --from=builder`)
- **레이어 및 캐시 최적화:**
  - `RUN` 명령어를 `&& \`로 병합하여 불필요한 중간 레이어 생성 억제
  - 변경이 잦은 소스 코드 복사(`COPY . .`)를 Dockerfile 최하단에 배치하여 빌드 캐시 효율 극대화
- **비루트 사용자 운용 (Non-root USER):**
  - `RUN useradd -m appuser && USER appuser` 설정을 통해 컨테이너 내부 프로세스 권한 최소화
  - 호스트 시스템에 대한 잠재적 보안 리스크 차단
- **빌드 인자 활용 (ARG vs ENV):**
  - **ARG:** 빌드 시점에만 필요한 변수(버전 정보 등) 관리 (`docker build --build-arg ...`)
  - **ENV:** 컨테이너 실행 시 필요한 환경 설정값 관리

## 2. 기업형 이미지 관리 체계 (Harbor Registry)

이미지 자산의 중앙 집중 관리 및 신뢰 기반의 배포 환경 구축

- **Harbor 구축 및 프로젝트 관리:**

  - 사설 레지스트리 서버 설치 및 프로젝트 단위 저장소 분리
  - **보안 설정:** Role 기반 접근 제어(RBAC) 적용 및 이미지 취약점 상시/정기 스캔 기능 활성화
  - **인입 보안:** 저장소 Push 시점의 자동 취약점 스캔(Scanner 연동) 및 보안 임계치 초과 시 Push/Pull 차단 강제화

- **가비지 컬렉션 (GC):** 보관 주기 기반의 미사용 이미지 자동 삭제 스케줄링을 통한 스토리지 용량 최적화

## 3. 로컬 보안 가드레일 (Shift-Left Security)

코드 작성 및 커밋 단계에서 결함을 차단하는 전진 방어 체계

- **pre-commit 설정 및 강제화:** 커밋 직전 스타일 교정(Prettier) 및 파일 무결성 검증 자동 실행
- **Gitleaks 시크릿 유출 방지:** 소스 코드 내 API Key, 패스워드 등 민감 정보 포함 여부 실시간 감지 및 커밋 거부
- **ShellCheck 정밀 진단:** 쉘 스크립트(.sh)의 문법 오류, 논리적 버그, 잠재적 보안 취약점 사전 식별

## 4. 지속적 통합 보안 및 검증 (CI Security)

파이프라인 통과 단계별 자동화된 품질 검사 수행

- **SAST (Semgrep) 정적 분석:** 소스 코드 내 보안 취약 패턴 및 코드 스멜(Code Smell) 자동 탐지
- **SCA (pnpm audit) 종속성 감사:**

  - 프로젝트에서 사용하는 오픈소스 라이브러리의 알려진 취약점(CVE) 전수 검사
  - **보안 가드레일:** 위험 라이브러리 발견 시 파이프라인 빌드 실패(Fail) 처리 및 버전 업그레이드 강제화

- **Trivy 이미지 정밀 스캔:**
  - 최종 이미지 아티팩트의 OS 패키지 및 런타임 보안 결함 최종 검증
  - 분석 결과의 중앙 대시보드 전송 및 Slack/Email 연동 통보
- **자격 증명 보안 강화 (Credential Helper):** `pass` 및 `GPG`를 이용한 클라이언트 자격 증명 암호화 보관 설정
  - **설치:** `sudo apt install pass golang-docker-credential-helpers -y`
  - **명령어:** `python3 -c "import json, os; ... credsStore='pass' ..."` (config.json 자동 업데이트)

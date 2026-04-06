# Project Implementation Workflow & Task Log

본 문서는 에이전트와 사용자 간의 대화 내용을 바탕으로 도출된 인프라 구축 공정 및 향후 실습 계획을 순차적으로 관리하는 실행 가이드

---

## 1. 현재 진행 상황 (Current Progress)
사용자와의 협업을 통해 인프라 관리 체계 및 문서화 기반 마련 중

- **[완료] 문서 작성 원칙 수립:** 순수 명사형 종결 및 기술적 정교함 원칙 정의 (`GEMINI.md`)
- **[완료] 기술 지식 베이스 구축:** 엔터프라이즈 HA 및 관측성 분석 완료 (`docs/knowledge_base/`)
- **[완료] 실습 로드맵 확장:** Step 6(엔터프라이즈 HA), Step 7(AI 자동화) 단계 신설 (`docs/to-do-list.md`)
- **[완료] 루트 디렉토리 최종 정리:** 모든 소스 `docs/` 하위 이동 및 일원화 완료
- **[완료] 웹 포털 인프라 구축:** MkDocs Material 환경 설정 및 최종 빌드 검증 완료
- **[진행 중] 엔터프라이즈 HA 환경 구축:** MariaDB Galera Cluster 아키텍처 설계 및 가이드 작성 중

---

## 2. 단기 실행 과제 (Immediate Actions)
웹 포털 안정화 및 형상 관리 최적화를 위한 잔여 작업

### 2.1 최종 검증 및 배포 (Final Validation)
1. **웹 포털 빌드 검증:** `mkdocs serve`를 통한 레이아웃, 검색, 내비게이션 기능 전수 확인
2. **경로 무결성 검토:** 모든 마크다운 문서 내 참조 경로 및 이미지 출력 상태 확인
3. **최종 분할 커밋:** `docs/CURRENT_TASK_GUIDE.md` 전략에 따른 논리적 단위 커밋 실행

### 2.2 운영 고도화 설계
1. **CI/CD 파이프라인:** GitHub Actions 기반 자동 웹 배포 체계 구축 검토

---

## 3. 중장기 기술 구현 과제 (Technical Roadmap)
로드맵(Step 6-7)에 명시된 핵심 인프라 기술의 실제 구현 단계

### 3.1 Step 6: 엔터프라이즈 고가용성 DB 환경
- **과업:** 직접 구성 방식의 Galera Cluster + ProxySQL 아키텍처 설계 및 구현
- **상세 내역:**
    - Proxmox 내 3개 노드 VM 프로비저닝 (Terraform 활용 검토)
    - MariaDB Galera Cluster 기반 동기식 복제 구성
    - `garbd`를 이용한 쿼럼 유지 및 비용 최적화 실습
    - ProxySQL을 통한 Read/Write 분할 및 장애 조치(Failover) 테스트

### 3.2 Step 7: 클라우드 네이티브 및 AI 관측성
- **과업:** Thanos 기반 멀티 클러스터 통합 모니터링 및 AI 부하 예측 도입
- **상세 내역:**
    - Thanos Receiver/Query 아키텍처 구현
    - k6를 이용한 p95 지연 시간 정밀 성능 분석
    - MS AI 모델 연동을 통한 선제적 오토스케일링(KEDA) 체계 검증

---

## 4. 대화 기반 의사결정 기록 (Decision Log)
- **[2026-03-31] DB 구축 방식:** 직접 구축(Self-managed) 방식 채택 (학습 깊이 우선)
- **[2026-03-31] 문서화 도구:** MkDocs Material 도입 (엔지니어링 톤 유지)
- **[2026-04-01] 소스 관리 전략:** 분석용 소스(`lecture/`)를 `docs/` 하위에 두되 웹 메뉴에서는 제외하여 루트를 정결하게 유지
- **[2026-04-06] 데이터 보존 전략:** 컨테이너 데이터 유실 방지 및 백업 가시성 확보를 위해 호스트 물리 귀속(Bind Mount) 방식 필수 원칙 수립

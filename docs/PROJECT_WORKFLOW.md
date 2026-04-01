# Project Implementation Workflow & Task Log

본 문서는 에이전트와 사용자 간의 대화 내용을 바탕으로 도출된 인프라 구축 공정 및 향후 실습 계획을 순차적으로 관리하는 실행 가이드

---

## 1. 현재 진행 상황 (Current Progress)
사용자와의 협업을 통해 인프라 관리 체계 및 문서화 기반 마련 완료

- **[완료] 문서 작성 원칙 수립:** 순수 명사형 종결 및 기술적 정교함 원칙 정의 (`GEMINI.md`)
- **[완료] 기술 지식 베이스 구축:** 엔터프라이즈 HA(Ceph, Galera) 및 관측성(Thanos) 분석 완료 (`docs/knowledge_base/`)
- **[완료] 실습 로드맵 확장:** Step 6(엔터프라이즈 HA), Step 7(AI 자동화) 단계 신설 (`docs/to-do-list.md`)
- **[진행 중] 웹 포털 인프라 구축:** MkDocs Material 기반 환경 설정 및 문서 소스 `docs/` 일원화 작업 중
- **[완료] 루트 디렉토리 정리:** 불필요한 폴더(`disk_mount`, `vi편집기`, `우분투커널빌드`) 삭제 완료

---

## 2. 단기 실행 과제 (Immediate Actions)
웹 포털 안정화 및 형상 관리 최적화를 위한 잔여 작업

### 2.1 형상 관리 및 정리 (Git & Cleanup)
1. **커밋 실행:** `docs/CURRENT_TASK_GUIDE.md`에 제안된 분할 전략에 따라 잔여 변경 사항 커밋 (사용자 직접 수행)
2. **루트 최종 정리:** 마지막 남은 `lecture/` 폴더를 `docs/` 하위로 이동하여 통합 완료
3. **경로 무결성 검증:** 모든 마크다운 문서 내 참조 경로 및 이미지 출력 전수 검토

### 2.2 웹 포털 고도화 (MkDocs)
1. **로컬 프리뷰 가동:** `mkdocs serve` 실행을 통한 레이아웃 및 검색 기능 최종 점검
2. **자동 배포 설계:** GitHub Push 시 자동으로 웹 사이트가 빌드되는 CI/CD 파이프라인(GitHub Actions) 구성 검토

---

## 3. 중장기 기술 구현 과제 (Technical Roadmap)
로드맵(Step 6-7)에 명시된 핵심 인프라 기술의 실제 구현 단계

### 3.1 Step 6: 엔터프라이즈 고가용성 DB 환경 (Current Target)
- **과업:** 직접 구성 방식의 Galera Cluster + ProxySQL 아키텍처 설계 및 구현
- **상세 내역:**
    - Proxmox 내 3개 노드 VM 프로비저닝 (Terraform 활용 검토)
    - MariaDB Galera Cluster 기반 동기식 복제 구성
    - ProxySQL을 통한 Read/Write 분할 및 장애 조치(Failover) 테스트

### 3.2 Step 7: 클라우드 네이티브 및 AI 관측성
- **과업:** Thanos 기반 멀티 클러스터 통합 모니터링 및 AI 부하 예측 도입

---

## 4. 대화 기반 의사결정 기록 (Decision Log)
- **[2026-03-31] DB 구축 방식 선택:** 클라우드 RDS 대신 가용성 및 보안 학습을 위해 직접 구축(Self-managed) 방식 채택
- **[2026-03-31] 문서화 도구 선정:** 인프라 엔지니어링 톤 유지를 위해 MkDocs Material 도입 결정
- **[2026-03-31] 관리 체계 강화:** 단순 유지보수 작업을 구분하기 위한 `🧹 Chore` 분류 신설
- **[2026-04-01] 루트 정리 가속:** 불필요한 레거시 실습 폴더 3개 삭제 및 정리

# [Audit] 인프라 무결성 및 건강성 진단 마스터 체크리스트

본 문서는 인프라의 보안 취약점과 단일 장애점(SPoF)을 진단하고 개선하기 위한 프로젝트 범용 표준 가이드

---

## 1. 보안 하드닝 감사 (Security Audit)

- **접근 제어:** Root 로그인 제한, SSH PubKey 인증 강제, sudo 권한 최소화 여부 진단
- **네트워크 보안:** UFW/IPTables의 Default Deny 정책 및 서비스 포트 화이트리스트 검증
- **취약점 스캔:** Trivy/ClamAV를 통한 컨테이너 이미지 및 OS 패키지 최신 보안 상태 유지

## 2. 가용성 및 SPoF 진단 (HA Audit)

- **데이터 이중화:** DB(Galera), 스토리지(Ceph)의 데이터 복제본이 최소 3개 이상 유지 여부 점검
- **서비스 페일오버:** 하이퍼바이저/로드밸런서(MetalLB/HAProxy) 장애 시 자동 DNS 전환 및 트래픽 분산 테스트
- **스토리지 복구:** 네트워크 파일 시스템 및 블록 스토리지 장애 시 서비스 자동 재연결 능력 확인

## 3. 설정 드리프트 감사 (Configuration Audit)

- **GitOps 동기화:** Argo CD/Argo Rollouts를 통한 클러스터 설정 상태와 Git 정의값 일치 여부 확인
- **설정 자동 반영:** ConfigMap/Secret 변경 시 파드 자동 롤링 업데이트 체계(Reloader) 작동 여부 점검

---

## 4. 진단 자동화 로드맵

- **Phase A (가시성):** 인프라 리소스 맵 자동 생성 및 단일 장애점 시각화
- **Phase B (규정 준수):** CIS Benchmark 표준 기반 실시간 감사 리포트 발행
- **Phase C (회복 탄력성):** 장애 시나리오 주입(Chaos Engineering) 및 자동 복구 검증

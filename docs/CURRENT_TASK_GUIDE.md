# Current Active Task Execution Guide

본 문서는 엔터프라이즈 HA 환경 구축의 첫 단계인 'MariaDB Galera Cluster' 설계를 위한 상세 실행 매뉴얼

---

## 🏗️ 1단계: DB HA 클러스터 설계 및 가이드 확인
실무 구축 전 아키텍처 및 요구사항 숙지

- **작업 대상:** `docs/to-do-space/step6_enterprise_ha/02_galera_cluster/README.md`
- **핵심 확인 사항:**
    - 3개 노드의 IP 주소 및 역할 매핑 확인
    - 클러스터 통신용 필수 포트(4567, 4568, 4444) UFW 개방 계획 수립
    - `galera.cnf` 설정 내 `wsrep_cluster_address` 구성 이해

---

## 🚀 2단계: 가상 머신(VM) 프로비저닝
Proxmox 환경을 이용한 DB 노드 3대 인프라 준비

- **작업 절차:**
    1.  **기본 노드 생성:** Ubuntu 24.04 LTS 기반 VM 1대 설치 (호스트명: `db-node-01`)
    2.  **초기 설정:** 업데이트 실행 및 MariaDB 패키지 사전 설치
    3.  **클론 생성:** `db-node-01`을 'Full Clone'하여 `db-node-02`, `db-node-03` 생성
    4.  **네트워크 개별화:** 각 노드 진입 후 IP 및 호스트명 고정 (192.168.100.11~13)

---

## 🌿 3단계: 형상 관리 (Git)
신규 설계 가이드 및 워크플로우 업데이트 내역 커밋

### [커밋 제안] Step 6 DB HA 클러스터 설계 반영 (Feature)
- **대상:** `docs/PROJECT_WORKFLOW.md`, `docs/CURRENT_TASK_GUIDE.md`, `docs/to-do-space/step6_enterprise_ha/02_galera_cluster/README.md`
- **커밋 메시지:**
  ```text
  feat: Step 6 DB HA(Galera Cluster) 아키텍처 설계 및 가이드 구축

  - MariaDB Galera Cluster 3-Node 멀티 마스터 아키텍처 수립
  - 클러스터 구축을 위한 네트워크 포트 및 설정 가이드 작성
  - Proxmox 기반 VM 프로비저닝 단계 가이드화
  ```

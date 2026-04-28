# Ansible 입문 가이드

## Ansible 개요

- **정의:** 구성 관리, 앱 배포, 서비스 오케스트레이션 자동화 도구.
- **주요 특징:**
  - **에이전트리스(Agentless):** SSH 기반 작동, 대상 서버 별도 설치 불필요.
  - **멱등성(Idempotency):** 반복 실행 시에도 최종 상태 동일 유지.
  - **YAML 기반 플레이북:** 가독성 높은 선언적 설정 방식 채택.

## 기본 구성 요소

- **제어 노드(Control Node):** Ansible 명령 및 플레이북 실행 주체.
- **관리 노드(Managed Nodes):** 자동화 대상 서버군.
- **인벤토리(Inventory):** 관리 대상 노드 리스트 및 그룹 정의.
- **플레이북(Playbooks):** 자동화 작업 절차를 정의한 YAML 스크립트.
- **모듈(Modules):** 실제 작업 수행 도구 (예: `apt`, `copy`, `service`).

## 주요 명령어

- **노드 연결 상태 확인:** `ansible all -m ping -i inventory.ini`
- **플레이북 실행:** `ansible-playbook -i inventory.ini site.yml`
- **단일 작업(Ad-hoc) 수행:** `ansible all -m apt -a "name=nginx state=present" -b`

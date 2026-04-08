---
marp: true
theme: default
class: invert
paginate: true
backgroundColor: #1a1a1a
header: "Cloud Infra Project: Security & Availability"
footer: "Infrastructure Standard Kit - 2026-04-07"
style: |
  section.lead h1 {
    text-align: center;
    color: #00d4ff;
  }
  section.architecture table {
    width: 100%;
    border-collapse: collapse;
  }
  section.architecture td {
    border: 2px solid #444;
    padding: 15px;
    text-align: center;
    font-weight: bold;
  }
  .highlight { color: #ffcc00; }
  .security { color: #ff4d4d; }
  .availability { color: #4dff4d; }
---

# ☁️ Cloud Infra Project
### 엔터프라이즈급 인프라 보안 및 가용성 표준화 모델
**Project Blueprint & Implementation Strategy**

---

# 📋 목차 (Table of Contents)

1. **[Vision]** 프로젝트 배경 및 핵심 목표
2. **[Architecture]** Phase별 인프라 설계 프레임워크
3. **[Security]** 다중 방어 기반 보안 가드레일
4. **[Availability]** SPoF Zero화를 위한 HA 전략
5. **[Operations]** 데이터 기반 관측성 및 자동화
6. **[Conclusion]** 성과 지표 및 향후 로드맵

---

# 01. 도입 및 비전 (Vision & Goals)

### 📌 배경 및 페인 포인트
- **수동 설정의 한계:** 설정 누락으로 인한 보안 취약점 및 운영 휴먼 에러 발생
- **가용성 부재:** 단일 장애점(SPoF) 존재 시 하드웨어 결함에 의한 서비스 중단 치명적

### 🚀 핵심 전략 (Core Pillars)
- **표준 환경 키트(Starter Kit):** 어떤 환경에서도 즉시 도입 가능한 보안/가용성 모델
- **엔지니어링 무결성:** 코드 작성부터 배포까지 자동화된 <span class="highlight">품질 관리 체계(CI/CD)</span> 수립

<!--
[발표자 스크립트]
반갑습니다. 본 프로젝트는 현대적 인프라가 직면한 두 가지 핵심 과제인 '보안'과 '가용성'을 해결하기 위해 시작되었습니다.
우리는 단순히 서버를 구축하는 것을 넘어, 누구나 즉시 적용할 수 있는 '표준 환경 키트'를 제공하고, 
모든 변경 사항이 자동으로 검증되는 '엔지니어링 무결성'을 확보하는 것을 최우선 목표로 합니다.
-->

---

# 02. 인프라 아키텍처 (Architecture Overview)

### 🏗️ Phase별 기술 스택 (Conceptual Model)

| 운영 영역 | 핵심 기술 및 솔루션 |
| :--- | :--- |
| **P4. Ops & CI/CD** | **Thanos**, **k6**, **Gitleaks**, **Terraform/Ansible** |
| **P3. Application/DB** | **Nginx Proxy**, **MariaDB Galera Cluster**, **ProxySQL** |
| **P2. Storage/Network** | **Ceph** (Distributed Storage), **LVM/ZFS**, **VLAN** |
| **P1. Infrastructure** | **Proxmox VE** (Hypervisor), **Ubuntu Server** (Hardened) |

<!--
[발표자 스크립트]
프로젝트의 전체 아키텍처입니다. 
가장 하단의 Proxmox 하이퍼바이저를 시작으로, Ceph 분산 스토리지와 Galera Cluster를 통한 데이터 가용성을 확보합니다. 
그 위에서 Thanos와 k6를 이용한 정밀 관측 시스템이 운영되며, 
Terraform과 Ansible을 통해 전체 인프라를 코드로 관리(IaC)하는 구조입니다.
-->

---

# 03. 다중 보안 방어 체계 (Security Guardrails)

### 🛡️ Shift-Left: 보안의 전진 배치
- **<span class="security">Gitleaks</span>:** API Key, Secret Token 등 민감 정보 유출을 로컬 커밋 단계에서 차단
- **<span class="security">ShellCheck</span>:** 인프라 스크립트의 논리적 버그 및 보안 결함 사전 진단
- **<span class="security">Prettier</span>:** 코드 스타일 표준화를 통해 가독성 및 유지보수성 극대화

### 🔒 공급망 보안 및 시스템 감사
- **SCA (Dependency Audit):** 오픈소스 라이브러리의 알려진 취약점(CVE) 실시간 스캔
- **auditd 정책:** 커널 레벨에서 핵심 설정 파일 변조 및 명령어 실행 이력 정밀 추적

<!--
[발표자 스크립트]
보안은 사후 대응이 아닌 '사전 차단'이어야 합니다. 
우리는 Gitleaks와 ShellCheck를 통해 코드가 공유되기 전 보안 결함을 90% 이상 제거합니다.
또한 시스템 내부적으로는 auditd를 운용하여 모든 명령어 실행 이력을 추적함으로써 침입 탐지 및 대응 능력을 확보했습니다.
-->

---

# 04. 무중단 가용성 아키텍처 (High Availability)

### ⚖️ 서비스 연속성 (99.9% Uptime)
- **DB HA:** 3개 노드 <span class="availability">Galera Cluster</span> 기반 동기식 멀티 마스터 복제
- **Compute HA:** <span class="availability">Proxmox Cluster</span>를 통한 노드 장애 시 VM 자동 페일오버
- **Load Balancing:** ProxySQL을 통한 지능형 쿼리 라우팅 및 Read/Write 분할

### 📂 데이터 가용성 및 복구
- **Ceph 스토리지:** 데이터 삼중화를 통해 디스크 장애 시에도 무중단 서비스 유지
- **PBS (Proxmox Backup Server):** 청크 단위 증분 백업으로 효율적인 재해 복구(DR) 체계 구축

<!--
[발표자 스크립트]
가용성 파트의 핵심은 '단일 장애점의 제거'입니다. 
데이터베이스는 Galera Cluster로, 하이퍼바이저는 Proxmox HA로 이중화되어 있습니다. 
특히 Ceph 분산 스토리지를 도입하여 물리적인 서버 한 대가 완전히 가동 불능이 되더라도 
사용자는 어떠한 중단도 느끼지 못하도록 설계되었습니다.
-->

---

# 05. 운영 자동화 및 관측성 (Ops & Observability)

### 📊 정밀 관측 및 성능 검증
- **Thanos 통합 관제:** 분산된 환경의 모니터링 데이터를 중앙에서 장기 보관 및 시각화
- **k6 벤치마킹:** p95(상위 5%) 지연 시간을 기준으로 인프라 신뢰도를 정량 측정

### 🤖 지능형 인프라 제어 (Next Step)
- **KEDA & AI 예측:** 부하 패턴을 AI로 분석하여 트래픽 유입 전 선제적 스케일링 수행
- **GitOps (Argo CD):** 인프라의 '현재 상태'와 '코드에 정의된 상태'를 실시간 동기화

<!--
[발표자 스크립트]
이제 인프라 운영은 데이터 기반으로 이루어집니다. 
단순히 '서버가 켜져 있다'는 확인을 넘어, k6를 통해 서비스의 95% 응답 속도가 기준치 안에 있는지 실시간 검증합니다. 
나아가 AI 예측 모델을 연동하여 부하가 발생하기 전 미리 자원을 확장하는 선제적 대응 체계를 갖추고 있습니다.
-->

---

# 06. 결론 및 향후 계획 (Conclusion & Future)

### 🏆 프로젝트 기대 효과
- **보안 신뢰성:** 자동화된 가드레일을 통한 설정 오류 및 보안 사고 제로화
- **운영 효율성:** 반복적인 인프라 구축 및 관리 업무의 80% 이상 자동화
- **확장 용이성:** IaC 기반으로 하이브리드/멀티 클라우드로의 즉각적인 환경 복제 가능

### 🗺️ 향후 로드맵
- **Phase 6 확장:** Terraform 기반 Proxmox 프로비저닝 자동화 고도화
- **보안 강화:** Packer를 이용한 보안 하드닝 완료 Golden Image 빌드 체계 구축

---

# Q&A
## 감사합니다.

# Playbook: 안전한 인프라 업데이트 (Safe Infrastructure Upgrade)

## 📌 개요
- 시스템 안정성을 유지하면서 보안 패치 및 패키지 업데이트를 수행하는 표준 절차.
- 무분별한 `apt upgrade`로 인한 서비스 중단 리스크 최소화.

## ✅ 사전 준비 (Prerequisites)
- **스냅샷 및 백업 수행**
    - 가상화 환경(ESXi, Proxmox 등) 또는 클라우드 콘솔에서 VM 스냅샷 생성 권장.
    - DB 및 중요 설정 파일 별도 백업 확인.
- **실행 중인 서비스 확인**
    - `systemctl list-units --type=service --state=running`
    - 현재 운영 중인 핵심 서비스 리스트 파악.

## 🛠️ 1단계: 정보 수집 (Information Gathering)
- **패키지 리스트 갱신**
    ```bash
    sudo apt update
    ```
- **업데이트 대상 확인**
    ```bash
    apt list --upgradable
    ```
    - 커널(`linux-image-*`), DB, 웹서버 등 영향도가 큰 패키지 존재 여부 확인.

## 🛠️ 2단계: 선별적 업데이트 (Selective Upgrade)
- **리스크가 큰 패키지 개별 업데이트**
    - 전체 업데이트 전, 크리티컬한 패키지만 우선 업데이트하여 영향도 파악.
    ```bash
    sudo apt install --only-upgrade <package_name>
    # 예: sudo apt install --only-upgrade nginx
    ```
- **보류 설정 (Hold)**
    - 특정 버전 유지가 필요한 경우 업데이트 대상에서 제외.
    ```bash
    sudo apt-mark hold <package_name>
    ```

## 🛠️ 3단계: 검증 (Verification)
- **서비스 상태 점검**
    ```bash
    systemctl status <service_name>
    ```
- **재시작 필요 서비스 확인 (`needrestart`)**
    - 라이브러리 업데이트 후 프로세스 재시작이 필요한 항목 식별.
    ```bash
    sudo needrestart
    ```
- **로그 모니터링**
    - `tail -f /var/log/syslog` 또는 `journalctl -xe`를 통해 실시간 오류 확인.

## 🛠️ 4단계: 시스템 유지보수 (System Maintenance)
- **안전한 디스크 정리: `apt clean`**
    - `/var/cache/apt/archives` 내 다운로드된 패키지 설치 파일(.deb) 삭제함.
    - 설치된 프로그램에 영향 없이 디스크 공간 확보 가능하며 위험성 없음.
    ```bash
    sudo apt clean
    ```
- **선별적/제한적 정리: `apt autoremove`**
    - 사용되지 않는 의존성 패키지 삭제함.
    - **주의:** 수동 설치한 프로그램이 사용하는 라이브러리가 삭제될 리스크 존재함.
    - **권장:** 시뮬레이션(`sudo apt autoremove -s`) 후 삭제 목록을 전수 확인한 경우에만 제한적으로 수행함.

## 💡 전문적 조언 (Advice)
- **Staging 환경 우선 적용:** 운영 서버 적용 전 동일 사양의 테스트 서버에서 먼저 수행함.
- **보수적 정비:** 디스크 공간이 극도로 부족한 상황이 아니라면 `autoremove`보다는 `clean` 위주의 정비를 권장함.
- **Change Log 확인:** 주요 패키지(Nginx, MySQL 등) 업데이트 시 Breaking Change 여부 공식 문서 확인함.
- **점진적 배포:** 여러 대의 서버 운영 시 한 번에 모두 업데이트하지 않고 순차적으로 진행함.

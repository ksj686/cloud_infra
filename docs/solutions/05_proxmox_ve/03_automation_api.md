# Proxmox API 및 자동화 (Terraform)

Proxmox의 강력한 API를 활용하여 IaC(Infrastructure as Code)를 구현하고, 수작업 없는 인프라 관리를 실현할 수 있습니다.

### 1. API 토큰 및 권한(Role) 설정
자동화를 위한 보안 인증 방식을 구성합니다.

- **권한 생성 (Role)**: 
  - `Datacenter -> Permissions -> Roles`에서 필요한 권한 세트 생성 (예: VM 생성/삭제 권한만 부여).
- **API 토큰 생성**: 
  - `Datacenter -> Permissions -> API Tokens`에서 관리 사용자용 토큰 생성.
  - 'Privilege Separation' 체크 해제 시 사용자 권한을 그대로 상속받음.
  - 생성된 'Token ID'와 'Secret'을 반드시 안전한 곳에 기록.

### 2. Terraform Proxmox 프로바이드 설정
Terraform을 사용하여 VM 배포를 자동화하는 예시 구성입니다.

- **Provider 정의 (Sample)**:
  ```hcl
  provider "proxmox" {
    pm_api_url      = "https://[PVE_IP]:8006/api2/json"
    pm_api_token_id = "terraform@pve!token_name"
    pm_api_token_secret = "your-secret-key"
    pm_tls_insecure = true
  }
  ```
- **리소스 정의**:
  - `proxmox_vm_qemu` 리소스를 사용하여 CPU, RAM, 네트워크, 디스크 사양을 정의.
  - Cloud-init 설정을 통해 VM 생성 시 사용자 계정 및 네트워크 자동 주입.

### 3. 자동화 및 VM 클로닝의 이점
- **일관성 보장**: 미리 정의된 'Template'을 기반으로 VM을 클로닝하여 설정 오류 및 파편화 방지.
- **배포 속도**: 수작업으로 OS를 설치할 필요 없이 수 초 내에 신규 서비스 노드 배포 가능.
- **확장성 (Scalability)**: 부하 증가 시 Terraform 명령 한 번으로 다수의 인프라 자원 수평 확장 가능.
- **재현성**: 전체 인프라 구성을 코드로 관리하여 장애 시 즉각적인 복원력 확보.

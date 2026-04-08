- 특정 서버 디스크 용량 늘리고 싶을때

  1. snapshot 지워야 늘릴 수 있음

  ![image.png](attachment:3d734f8c-cdd0-4e93-9ecf-385a162de920:image.png)

  1)도구 설치
  sudo apt update && sudo apt install cloud-guest-utils

  2)파티션 확장 (sda의 2번 파티션 확장)
  sudo growpart /dev/sda 2

  3. ext4 파일시스템 기준 확장
     sudo resize2fs /dev/sda2

  4)Compact 를 누르면 사용하지 않는 공간 정리?

  1.  새로운 하드디스크 add(그냥은 안올라옴. )
      [(책)이것이우분투리눅스다](https://www.notion.so/31b797a31b6e809ab3ebf914a2792874?pvs=21) → ‘p.386~396 vmware에 하드 추가’ 내용 참고

          ![image.png](attachment:e1ceeddb-76b9-44a2-aae5-37a3d22407de:image.png)

          SCSI(보통 이거) → Create a new virtual disk(보통 이거) → allocate all disk space now 체크하면 처음부터 설정한 용량만큼 할당됨. 체크 안하면 사용하는 용량만큼 커짐

          ![image.png](attachment:f5e9556f-cd8e-4f0a-86c7-7e517fd66d05:image.png)

**ctrl + alt ⇒ 화면에서 마우스 커서 밖으로 나올 수 있음**

- 20260306

  workstation이전에는 라이센스 정책 때문에 일반 사용자는 player를 썼음.

  그러나 이젠 사용 가능

  VMWare workstation, player 둘의 차이

  1. 동시에 실행했을때 player는 메인 화면에 띄운것 외에 다른 머신은 안보임
  2. 네트워크에 대한 설정변경 불가

  MAC에서는 VMWare 퓨전이라는 프로그램을 받아서 쓰면 된다.

  VMWare 설치 후

  네트워크 및 인터넷 설정 → 고급 네트워크 설정
  여기에서 VMWare NetworkAdapter VMnet8/1 이 두개를 볼 수 있음

  이중 8번이 NAT로 DHCP 로 동작

  VMWare 설치 후 문서 폴더에 Virtual Machines 폴더 생성 후 강사님이 주신 zip 파일 압축 풀기

  Home tab 실수로 닫으면 tabs → Go to home tab

  - 우분투 서버

    Virtual Machines\우분투서버\우분투서버.vmx

    power on

    id: kosa

    pw: kosa1004

  - 우분투 데스크탑

    데스크탑 자체의 poweroff와 VMWare에서 power off 하는 것의 차이. 물리적 power off와 달리 데스크탑 내부의 power off는 돌고 있는 프로그램들이 다 종료될 때까지 기다리기 때문에 더 느리다

  - **alpine-linux**

    압축 푼 후 import 방법 - open a Virtual Machine
    Virtual Machines\alpine-linux\alpine-linux.vmx

    Edit virtual machine settings - 원하는대로 가상머신 상태 변경 가능

    처음 실행시키면 다음과 같은 이미지 뜸. I Copied it 선택하면 됨

    ![image.png](attachment:08f2ffdb-b9fa-476d-b0ff-187c9a7f9dfe:image.png)

    서버이기 때문에 마우스 드래그로 block 설정이 안됨.

    전체하면 - Enter full screen mode

    ![image.png](attachment:5e2c3261-8744-4e6d-91e7-9ca791b29f6a:image.png)

    id: kosa

    pw: kosa1004

    서버 전원 버튼

    ![image.png](attachment:b5010005-61cb-4861-aec0-6e942b989560:image.png)

  suspend(절전모드)를 누르면 추후 Resume this virtual machine 으로 다시 on 상태로 변경 가능

**특정 서버가 충돌나서 실행되지 않는 경우** - .lck 파일들과 .vmem 파일을 지워주면 된다
play 버튼이 안떠도 동일하게 대처하면 됨. 종료 안되는 경우 작업관리자로 강제종료한 후 작업관리자에서 vmware vmx 도 종료한 뒤 위와 같이 진행하면 된다.

- Snapshot 방법

  ![image.png](attachment:089df51e-a435-4a75-b7e6-61cc131e2058:image.png)

  → Take Snapshot… 선택 후 저장

  ![image.png](attachment:44bd8d01-4fcb-4c14-9069-de8e9fdbb698:image.png)

  → Snapshot Manager 선택

  ![image.png](attachment:ceee7835-920c-4b7b-861b-631302352242:image.png)

  →

  ![image.png](attachment:6b621fbb-db2d-4156-913f-2b266c3cb268:image.png)

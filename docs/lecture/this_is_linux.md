- **20260306**

  내 PC 우클릭 → 추가옵션 표시 → 관리 → 저장소 → 디스크 관리 →

  EFI 시스템 파티션: 윈도우 파티션. 제일 처음 실행하는 것.

  멀티부팅은 파티션 분할 후 한번에 하나의 운영체제만 가동할 수 있는 환경. 가상머신은파티션 나누지 않고 동시에 여러 OS 가동

  스냅샷 - 현재 상태를 파일로 저장하는 것

  가상머신 설치를 위해서는 이미지가 필요하다 → ubuntu download에서 server 다

  alternative-downloads → All Ubuntu mirrors → Korea, Republic of - 카카오나 카이스트가 빠

  pdf p.43~ 가상머신 설치 절차

  - **ubuntu server 가상머신 설치**

    create a new … → 되도록 typical로 → browse 클릭후 iso 파일 선택 → 가상머신 이름 설정 → 디스크 사이즈는 20GB로 설정, 설정한 20GB를 분할할지(split virtual disk into multiple files) 혹은 하나로 할지 선택. 하나가 조금 더 빠름. 그러나 유연성은 split → customize hardware→ 서버는 메모리 2GB로 충분, USB와 사운드 카드는 필요없기때문에 Remove → finish
    부팅되면 try or install ubuntu server 선택 → English → update to the new installer → (업데이트 진행후) 키보드 설정은 그대로 써도 됨. 지금은 Korean → Ubuntu server(minimized) = 최소버전 설치 → 네트워크 설정(VMWare 내부적으로 사용되는 스위치) 은 일단 냅두고 Done → proxy server(대리서버) 우리는 없으므로 그냥 넘어감 → done → LVM 그룹 set up 안하고 쓸것임. 기존에 체크된 것 없애고 done → 파티션 어떻게 만들 것인지 보여줌. bios는 1mb, 그외 나머지 → continue → 사용자 정보 입력화면. user name: kosa / server name: kosa-server / pick a username: kosa / pw: kosa1004 → 업그레이드는 일단 스킵(skip for now) → install openSSH server는 반드시 체크! (이게 있어야 외부에서 접속이 가능하다.) → 여러 리스트나옴. 체크 하지 말고 done → 설치 다 되면 밑에 reboot now뜸. reboot 선택. 로그 보면 또다시 설치하는걸 방지하기 위해 cdrom을 의도적으로 막아버림. **엔터 누르면 실행** → (네트워크 문제있으면 3분정도 기다려야함. 로그인화면으로 자동으로 안넘어가지면 엔터 누르면 로그인화면 뜸) id pw 치면 로그인됨

    ip주소 확인 ⇒ ip a

    lo: loopback 내부에서만 작동.

    ![image.png](attachment:9ec465b9-ba49-4187-b1dd-ca267b30c6e3:image.png)

    192.168.254.131이 이 가상머신의 ip이다.

    ip는 논리주소이다. 물리주소는 physical address - link/ether… 물리주소는 네트워크 카드마다 별도로 부여됨.

  **윈도우 호스트 터미널로 실행** → ssh [kosa@192.168.254.131](mailto:kosa@192.168.254.131) (계정명@가상머신 ip) → 최초 접속때는 지문(hash code) 등록을 함.
  최초 접속때 yes 입력해야 접속 가능
  ⇒ 터미널로 접속했기 때문에 블록 설정이 가능하고 복사 붙여넣기도 가능하다.

  **bridge 로 설정하면 같은 네트워크 내부에서 direct로 접속 가능. 마치 같은 네트워크 내부의 새로운 PC에 랜선 연결한 것과 같은것. bridge는 여러 사람과 통신하는게아니면 잘안쓴다.**

  - **bridge 설정**

    VMWare 탭에서 해당 OS 우클릭후 settings 들어가서 세팅 변경하려면 해당 가상머신 전원끄고 진행해야한다.

    **전원끄고** 네트워크 설정 변경

    ![image.png](attachment:beb398d0-3825-4189-96c4-06582e79d39e:image.png)

    ip a 입력하면 바뀌어있는걸 확인 가능

    ![image.png](attachment:0213cfee-08ce-43d5-a858-a76d55e6c584:image.png)

    - **ip 가 안나오는 문제 발생! 해결 방법**

      VMware 메뉴에서 `Edit` > `Virtual Network Editor`를 실행했을 때, 오른쪽 하단에 **[Change Settings]** 버튼이 보인다면 반드시 그걸 먼저 클릭해야 합니다. 관리자 권한이 없으면 Bridged 네트워크(VMnet0)가 목록에서 아예 안 보일 수 있습니다.

      ### VMnet0 수동 추가하기

      만약 관리자 권한으로 들어갔는데도 VMnet1, 8만 있다면 직접 추가해야 합니다.

      1. **[Add Network...]** 버튼을 클릭합니다.
      2. 드롭다운 메뉴에서 **VMnet0**를 선택하고 OK를 누릅니다.
      3. 새로 생긴 **VMnet0**를 선택한 뒤, 하단의 **VMnet Information** 섹션에서:
         - **Bridged (connect VMs directly to the external network)** 선택
         - **Bridged to:** 설정을 `Automatic`이 아닌, **현재 인터넷이 연결된 실제 랜카드 이름**으로 직접 고정하세요. (예: `Killer(R) Wi-Fi...` 또는 `Realtek PCIe GBE...`)
      4. **[Apply]** 또는 **[OK]**를 눌러 저장합니다.

    문제가 해결되면 아래와 같이 ip 정상적으로 나옴

    ![image.png](attachment:b2b0128a-f86c-4a41-a98e-eeeaad141e23:image.png)

    mkdir 내영어이름 → 윈도우 터미널 접속 → ssh kosa@위의ip

    ls 입력하면 폴더 보임

  pdf p.60 - 가상머신 종류

  - **OS 다운**

    **alpine linux** 검색 → downloads → standard 여러가지는 cpu 종류들. 보통 x86_64

    **~~windows server** download → 영어 ISO 64비트 버전 다운(한국어는 영어에 한글 패키지 설치해서 사용하는것)~~

    windows 11 다운

    ![image.png](attachment:3e7293d1-5504-48f1-a522-aba73b42c439:image.png)

  - **alpine linux 설치**

    좌측패널에서 우클릭 → new virtual machine → browse 클릭, alpine standard 이미지→

    ![image.png](attachment:1d4027bf-a405-4e47-8c6f-e0920ada84ea:image.png)

    → version에서 Other Linux 6.x kerner 64-bit 선택 (Ubuntu 64-bit 선택해도 됨)→ alpine-server →

    20GB 설정, single file 선택 → customize hardware → memory 1GB, USB/hardware 지우기, (bridge 설정 원할경우 - network adapter에서 bridge로) → finish

    power on 한 후 root 입력하면 최상위 권한으로 바로 사용 가능. # 볼 수 있음.

    → setup-alpine → kr (한국어를 뜻함) → kr-kr104(혹은 kr) → alpine-server (서버이름)

    → (네트워크 이름) 그냥 엔터 → 그냥엔터(dhcp로 설정) → [n] (자동으로 받아옴) → kosa1004 → (시간 설정) Asia → Seoul → proxy 서버 없으므로 그냥 엔터 → (기본값 busybox) 그냥 엔터 → (기본값 1) 그냥 엔터 → set up user: kosa , full-name: kosa, pw: kosa1004 → (ssh 접속시 키 입력하거나 인증서 방식으로 할 수 있다. )그냥 엔터 → 그냥 엔터 → (디스크 설정) sda → sys → y → 포멧하고 설치 됨

    please reboot 메시지 뜨면 설치 완료된 것. reboot 입력(reboot 명령어는 관리자만 사용 가능하다)

  - **ubuntu desktop 설치**

    좌측패널에서 우클릭 → new virtual machine → browse 클릭, ubuntu desktop 이미지 →
    full name: kosa, user name: kosa, pw: kosa1004 → Ubuntu-desktop → (데스크탑은 UI가 있으므로 용량을 늘리는게 좋음) 40GB, single → customize hardware →

    ![image.png](attachment:43734567-a31b-4b3d-aad1-02f4a9de88ff:image.png)

    processors 2, core per processor 2 → finish

    UI 있는 설치화면이 나옴 → install 버튼 클릭 → (언어선택) 한국어 → 접근성은 바꾸는 것 없이 다음 → 키보드 레이아웃 한국(기본값으로 되어있음) → 유선연결(기본값) 다음 → 설치 선택 후 다음(기본값)→ 대화형 설치 → 기본 설치 → 권장 소프트웨어 선택없이 다음 → 디스크지우고 설치(기본값) → 계정 설정 - 이름 kosa, 컴퓨터이름 kosa-desktop, 사용자 kosa, pw: kosa1004 → 시간대 아시아 서울(기본값) → 선택사항 확인 후 설치진행 → 터미널 아이콘 누르면 설치 과정 확인할 수 있다.

    → 끝나면 다시 시작 클릭

    로그인 → 다음 → 지금은 건너뛰기 → 아니요, 시스템 데이터 공유하지 않음 → 마침

    좌측 상단의 버튼은 검색버튼 → terminal실행가능 → ip a 로 ip 확인

    우분투 데스크탑은 openssh 설치를 자동으로 해주는 옵션이 없다.

    **ssh 설치!**

    sudo apt install openssh-server
    openssh-server: 패키지 명

    서비스 상태 확인
    sudo service ssh status ⇒ enable / disable 중 어떤 상태인지도 확인 가능, inactive 면 stop 상태

    서비스 등록
    sudo systemctl enable ssh

    서비스 등록 해제
    sudo systemctl disable ssh

    서비스 시작
    sudo service ssh start

  - **윈도우 원격 데스크톱 연결로 ubuntu-desktop에 연결**

    https://glorychoi.tistory.com/entry/Windows-Ubuntu-%EC%9B%90%EA%B2%A9-%EB%8D%B0%EC%8A%A4%ED%81%AC%ED%86%B1-%EC%97%B0%EA%B2%B0-%EC%9C%88%EB%8F%84%EC%9A%B0-%ED%99%98%EA%B2%BD%EC%97%90%EC%84%9C-%EB%A6%AC%EB%88%85%EC%8A%A4-%EC%9B%90%EA%B2%A9-%EC%A0%91%EC%86%8D%ED%95%98

    위 url 절차대로 진행

    sudo apt update

    sudo apt install xrdp

    sudo service xrdp status

    xrdp: xwindow remote desktop protocol

    설치 로그에 /etc/xrdp/rsakeys.ini 라는 설정 파일경로 보임

    윈도우 원격 데스크톱 연결로 ubuntu-desktop에 연결

    ![image.png](attachment:ef3b7fe5-32f8-4b0e-9976-007a57ab7710:image.png)

    ![image.png](attachment:8ec71dee-13f8-4011-82fd-e08064196ab3:image.png)

    → 자격 증명 저장 허용 체크 \***\*주의! : 로그인되어있는 사용자가 있으면 연결 안됨.**

    \***\*원격접속했을때 terminal 안켜지는 에러** ⇒ 다른 프로그램 켰다가 터미널 키면 해결

  - **윈도우 서버 설치**

    new virtual machine → typical → **(여기서부터 공유된 설치 pdf 참고)** SERVER_EVAL_x64FRE_en-us.iso → 키

    WX4NM-KYWYW-QJJR4-XV3QB-6VM33

    kosa / kosa1004 → yes → 서버명은 그대로 →60GB, multi file → customize hardware → 메모리 4GB, cpu 4개(2\*2) → 이미지 없다고 나옴

  - **VMWare 가상 머신 완전 삭제**

    우클릭 → remove → 해당 경로에 가서 직접 파일도 지우기!

  - **VMWare 가상머신 설치된 경로의 파일 확장자**

    lck - 다른 프로그램이 지우거나 수정할 수 없도록 lock 걸린것

    vmem - 실행중 메모리 상태. 렘에 관한 것. 처음에 렘 설정을 1GB로 했으면 실행중일때 해당 파일의 크기도 1GB이다. 가상머신을 종료하면 해당 파일은 사라진다.

    vmx - 가상머신 설정파일. 세팅화면의 값들이 저장되는 것. text 파일이다.

    vmdk - 하드디스크. 20GB로 설정했지만 243MB ⇒ 실제 사용되는 저장 공간. 최대 용량이 20GB. single로 설정했기때문에 파일이 하나. split multi로 설정했으면 여러개. 점점 늘어남.

  - **패키지 관리**

    sudo apt update ⇒ 현재 설치 가능한 최신 버전 정보를 가져옴

    sudo apt upgrade ⇒ 기존 프로그램에 대한 업그레이드. 신규 설치 X

    → y 입력

    sudo apt install vim ⇒ 원하는 패키지 설치

    sudo apt install vim -y ⇒ 모든 물음에 전부 y로 자동으로 선택

    sudo apt remove 패키지이름 ⇒ 환경설정정보 파일들을 제외한 나머지 제거

    sudo apt purge 패키지 이름 ⇒ 환경설정정보 포함한 전부를 제거

    패키지 존재여부 검색

    apt search 패키지명

- **20260311**

  pdf p.69

  ip주소: 의미 부여 주소 / domain address

  도메인 주소 [www.naver.com](http://www.naver.com) : 논리 223.130.200.236

  dns(domain name server) : 영문을 치면 ip로 변환해 줌

  ***

  **vmware의 네트워크 장치**

  vmware를 설치하면 제공하는 네트워크 장치 두개(1번, 8번)
  VMnet1은 호스트와 통신하는 것만이 목적. 외부 통신이 안됨
  VMnet8은 사설망 구축. 공유기가 있다고 가정하면 됨. 다른 말로 NAT(network address trans) 서버
  ⇒ ip하나를 서로 다른 아이피로 바꿔줌.
  ip 발급 범위 - ~.~.~.128~254

  ![image.png](attachment:18996292-5b4a-4025-a532-c2d488c50c06:image.png)

  서로 다른 PC에 설치된 VMware의 서버(NAT 로 설정된) 사이에는 서로 통신이 안됨. 위의 ip가 같더라도 당연히 안됨.

  ![image.png](attachment:86803da0-c3f9-4dc8-8bd0-70aa1b119ab2:image.png)

  ![image.png](attachment:1f16b9b1-668b-4457-ae3b-c4cf9673f6b6:image.png)

  ⇒ 대역 변경함.
  Default lease time: 임대 시간. 사용하지 않은지 30분이 지난 후에는 다른 pc가 해당 ip를 쓸 수 있는 상태가 된다.

  ![image.png](attachment:47d40234-2343-4b9a-b062-db2090841f10:image.png)

  <그림설명>
  위의 설정에서 VMnet1은 외부 연결 안됨.
  192 대그룹, 168 중그룹, 159 소그룹, 1~255 부분주소(디테일). 0 은 그룹을 대표하는 대표명.

  ![image.png](attachment:9065163f-f39f-443d-880a-6603b3e6c422:image.png)

  → change settings 클릭하면 VMnet0 하나가 더 보임

  ![image.png](attachment:3f82c730-75f8-4cf0-943d-16b3c433b10c:image.png)

  bridge를 선택하면 아이피를 NAT에서 발급해주는 것이 아닌 기존 스위치에서 발급받는다.

  ***

  WAN 선(LG, KT, SK) → 스위치를 통해 각 컴퓨터로 연결됨
  다른 스위치에 연결된 컴퓨터 사이에는 통신이 안됨.

  ***

  ## **vmware 공유폴더 설정**

  pdf p.74 호스트 OS와 게스트 OS가 같이 공유할 수 있는 파일 공간을 만드는 방법

  먼저 실행되고 있는 게스트 OS 종료시키기 → C드라이브 밑에 vmshare 폴더 생성 →

  ![image.png](attachment:5dafc254-f8a5-4edf-ad8c-b5ab6ec3fb4a:image.png)

  우분투 서버 edit virtual machine settings →

  ![image.png](attachment:655662d6-a6e4-49b1-9d3b-01354b52cb3a:image.png)

  options 탭에서 shares folders always enabled 선택 → add 클릭 후 처음에 생성한 folder로 공유 폴더 설정(read-only를 선택하면 게스트 OS 에서는 읽기만 가능) → finish

  ![image.png](attachment:00cb6b61-0bc7-44d7-ba8b-e28f5091e0c2:image.png)

  (properties 누르면 좀 전의 설정들 수정 가능)

  → 공유 폴더 인식을 위해 게스트 OS(리눅스) 에서 필요한 프로그램 설치

  ### 우분투

  sudo apt install open-vm-tools open-vm-tools-desktop -y
  sudo reboot
  vmware-hgfsclient : 공유폴더 목록 확인
  sudo mkdir -p /mnt/hgfs/vmshare
  sudo mount -t fuse.vmhgfs-fuse .host:/vmshare /mnt/hgfs/vmshare -o allow_other
  만약 잘못된 폴더명으로 mount 한 경우 : sudo umount /mnt/hgfs/폴더명

  ### alpine-server

  vi /etc/apk/repositories → 맨 밑의 커뮤니티 url 주석처리 되어있는 # 지워준다.
  //(위의 과정 실행했으면 이 명령어 필요없음) setup-apkrepos -c -1 : 커뮤니티 저장소를 자동으로 찾아 활성화
  apk add open-vm-tools
  // rc-update add open-vm-tools boot
  // rc-service open-vm-tools start
  apk add open-vm-tools-hgfs
  vmware-hgfsclient : 공유폴더 보이는지 확인
  mkdir -p /mnt/hgfs/vmshare
  modprobe fuse
  vmhgfs-fuse .host:/vmshare /mnt/hgfs/vmshare -o allow_other
  // apk add fuse3

  참고 웹사이트: https://easyfly.tistory.com/1681

  **⇒ 위의 설정 후 게스트 OS /mnt/hgfs 에 공유 폴더 위치. 파일의 변경 실시간 반영**

  ***

  pdf p.79~ 2장 - 외울 필요없이 가볍게 읽어보기만 하면 되는 내용들

  ubuntu-desktop 에서 libreoffice 설치해보기

  ***

  pdf p.93~ 3장에서는 우리가 안해본 iso 파일 생성, 사용자/그룹관리 및 스냅숏에 관련된 내용 진행

  유닉스/리눅스/맥 은 전부최상위 폴더가 루트 / 이다.

  ## iso 파일 생성 및 mount

  p.220 boot 디렉토리의 파일들을 iso 파일로 생성

  sudo apt -y install genisoimage : iso 파일을 만들 수 있도록 하는 프로그램 설치

  ![image.png](attachment:0d3902e5-fbfb-4795-8e22-6d034c79d78a:image.png)

  sudo genisoimage -r -J -o boot.iso /boot

  root 계정으로 진행하기 싫으면 계속 sudo 명령어 앞에 붙이면 됨.

  **마운트**

  1. 연결할 폴더 생성
     mkdir /media/iso : root 권한 아니면 sudo 필요
  2. mount 명령어로 연결
     mount -o loop boot.iso /media/iso : read-only로 mount 됨
  3. 연결된 파일을 사용
  4. umount로 연결 해제
     umount /media/iso
  5. 폴더 필요 없으면 삭제
     rm -r /media/iso

  - **사용자 / 그룹 관리**

    p.224-225

    /etc/passwd : 사용자 정보 파일

    root:x:0:0:root:/root:/bin/bash - 각 행은 콜론(`:`)으로 구분된 7개의 데이터 필드로 구성

    ![image.png](attachment:4c01704f-c8c2-47af-b04d-4688507e4dc4:image.png)

    - **사용자 이름 (Username):** 시스템 로그인 시 사용하는 계정명 (예: `kosa`)
    - **비밀번호 (Password):** 과거에는 암호를 저장했으나, 현재는 보안상 `x`로 표시 (실제 암호는 `/etc/shadow`에 암호화되어 저장)
    - **사용자 ID (UID):** 시스템이 사용자를 식별하는 숫자 (0은 항상 `root`)
    - **그룹 ID (GID):** 사용자가 속한 기본 그룹의 숫자 ID
    - **사용자 정보 (GECOS):** 사용자의 전체 이름, 연락처 등 부가 설명 (비워둘 수 있음)
    - **홈 디렉토리 (Home Directory):** 로그인 시 사용자가 위치하게 될 기본 경로 (예: `/home/kosa`)
    - **로그인 쉘 (Login Shell):** 사용자가 사용하는 커맨드 라인 인터페이스 종류 (로그인 가능한 계정: `/bin/bash`, `/bin/sh`)

    daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
    ⇒ 이렇게 nologin이 붙은 것은 로그인 못함. 유사한 것이 /bin/false
    pollinate:x:102:1::/var/cache/pollinate:/bin/false

    외부에서 데이터를 전달하는 방법

    /etc/group : 그룹에 관해 기록된 파일
    kosa:x:1000:

    ![image.png](attachment:9a02033c-8bde-4e24-ba02-e5e1ee62d95b:image.png)

    ### **p.225~229 사용자와 그룹 관련 명령어**

    adduser 사용자명 : **사용자 생성**
    sudo adduser --ingroup kosa user2 : user2를 kosa 그룹으로 생성
    그 외 관련 명령어들 pdf 참고

    passwd newuser1 : newuser1 **사용자의 비밀번호 변경**

    **사용자 속성 변경**
    usermod …
    usermod -g ubuntuGroup user2 : user2의 주그룹을 ubuntuGroup으로 변경

    **사용자 삭제**
    userdel 사용자명
    userdel -r 사용자명 : 사용자를 삭제하면서 사용자의 홈디렉토리도 삭제

    chage : **사용자의 암호**를 변경하도록 하는 명령어. pdf에서 다양한 옵션 참고

    groups 사용자명 : **사용자가 속한 그룹** 보여줌

    groupadd 그룹명: **그룹 추가**

    **그룹속성변경**: groupmod …

    **그룹삭제**: groupdel 그룹명

    **그룹 비밀번호 설정 혹은 그룹관리**: gpasswd …

    **p.229~233 까지 실습**

    **해커가 노리는 파일** /etc/passwd ⇒ 여기서 x만 지워버리면 비밀번호 없이 로그인할 수 있다. 혹여나 root 외의 사용자가 write 권한이 생기면 안됨.

  pdf p.236 파일 속성

  파일과 디렉토리의 소유권과 허가권

  touch

  - 존재하지 않는 파일이면 파일사이즈 0의 파일을 만들어줌
  - 존재하는 파일이면 시간을 현재로 바꿔줌

  권한은 chmod 숫자, 또는 chmod u+rwx 로 수정 가능

  ll /home ⇒ 각 계정 디렉토리의 권한을 보면 본인, 그룹에 속하지 않으면 권한이 아무것도 없다. 이것을 read로 변경해줘도 그 아래의 파일이나 폴더는 여전히 못읽음. 접근권한은 해당 파일에만 해당된다. 아래로 내려가려면 **상위폴더의 실행권한**이 있어야된다. 즉, **x 권한이 필요**

  drwxr-x--- kosa
  -rw-rw-r-- ├── a.txt
  -rw-rw-r-- ├── b.txt

- **20260312**

  - pdf p.239 **파일 소유권 변경**

    sudo chown root a.txt : root로 사용자 변경. root는 권한이 높기 때문에 sudo
    sudo chgrp root a.txt :그룹도 변경 가능
    sudo chown kosa:kosa a.txt : 사용자와 그룹 동시에 변경

    ![image.png](attachment:36c66750-bcba-4d59-a2b8-a79adbac8c79:image.png)

  ubuntu-desktop에서는 아래의 편집기 쓰면 편함

  ![image.png](attachment:64972d4b-4a87-472e-812b-dafe26df08b7:image.png)

  whoami : 사용자 확인(우분투에서는 별 도움이 안되지만 alpine에서는 필요함)

  ~kosa : 사용자 kosa의 홈디렉토리

  - p.245 **링크**

    하드 링크는 i노드의 주소값이 같지만 심볼릭 링크는 i노드의 주소값이 다르다.

    ls -i : i노드의 위치가 나옴. 보통 6자리 숫자
    ln 원본파일명 링크파일이름 : 하드링크생성. 원본 파일을 서로 다른 이름으로 보기 원할때 사용
    ln -s 원본파일명 링크파일명 : 심볼릭 링크 생성

    cp a b ⇒ a와 b는 완전 분리된 파일
    ln a.txt ln-a.txt ⇒ 원본 파일을 서로 다른 이름으로 보기 원할때 사용. 둘은 같은 파일. 하나를 수정하면 다른 하나에 수정사항 반영됨

    ![image.png](attachment:aae5e9fd-9205-4e88-81d2-dacd2100dcb1:image.png)

    ln a.txt lns-a.txt : i노드 값이 다르고 상세보기 확인하면 → 가 붙어있음

    ![image.png](attachment:a489f915-716a-48ce-b9ed-d45b76612d52:image.png)

    원본 파일의 위치가 이동되면 심볼릭 링크는 원본파일을 찾지 못하고 깨진다.

    ![image.png](attachment:2423f57f-6830-4f0a-831a-b1049a4cdd47:image.png)

  - pdf p.249 프로그램 설치를 위한 **dpkg**

    deb 파일 형식 ⇒

    ![image.png](attachment:254db24c-ce88-4881-9eec-dd890968e8f7:image.png)

    dpkg -r 패키지명 : 설치된 패키지 삭제
    dpkg -p 패키지명 : 설치된 패키지 및 설정파일까지 제거
    dpkg -l 패키지명 : 패키지 조회
    dpkg -L 패키지명 : 관련 파일들이 어디에 설치되었는지 보여줌

    ![image.png](attachment:d17d7a42-613e-4a43-9270-da596e648e97:image.png)

    데몬 프로그램 = 서비스 프로그램

    **dpkg 명령어의 단점은 의존성. 개발자가 의존성을 해결해야함. 그러나 apt 명령어는 알아서 챙겨줌**

    ubuntu-desktop에서 galculator 다운받고 설치해보기

    브라우저에서
    https://archive.ubuntu.com/ubuntu/pool/universe/g/galculator/
    → galculator_2.1.4-2.1_amd64.deb 다운
    또는 터미널에서
    wget https://archive.ubuntu.com/ubuntu/pool/universe/g/galculator/galculator_2.1.4-2.1_amd64.deb

    dpkg --info galculator_2.1.4-2.1_amd64.deb : 패키지 정보

    패키지를 설치할때는 sudo 가 필요
    sudo dpkg -i galculator_2.1.4-2.1_amd64.deb

    ![image.png](attachment:be6949b7-e472-4d1d-ae7a-807e76bd391b:image.png)

    의존성 문제로 설치가 안된다. --force 옵션을 주면 강제로 설치는 하지만 실행되는건 보장못한다.
    이를 해결하기 위해 apt 명령어를 사용한다.

    패키지 원격지 서버 주소 확인 ⇒ cat /etc/apt/sources.list.d/ubuntu.sources

    ![image.png](attachment:1a4b2c09-576e-411a-a036-bd0a0f1f1e7e:image.png)

  - 패키지 관리 **apt**

    sudo apt --fix-broken install : 의존성 문제 해결

    apt install 패키지명 -y
    apt remove 패키지명 : 기존 설치된 패키지 삭제
    apt purge 패키지명 : 설정파일을 포함해서 삭제
    **apt clean : 설치할때 사용했던 내부 파일들을 깨끗하게 정리해줌**
    apt-cache show 패키지명 : 패키지 정보
    apt-cache depends 패키지명 : 의존성 정보

    설치된 패키지가 늘어날수록 설치파일들이 점유하는 불필요한 공간들이 늘어남. 이때 apt clean을 실행시킨다.

    7~8주 쯤 terraform을 활용해서 서버 여러개 설치하는것 진행할 예정

    가상머신생성 → 복사 → 엔서블로 50 가상머신생성

    삭제해보기

    apt --help : 명령어 확인
    apt remove 패키지명 : 삭제
    apt autoremove : 사용하지 않는 패키지 삭제

    ![image.png](attachment:329bfe34-2851-4bd6-913f-369d026b9be4:image.png)

    무료 저장소만 남기고 지워보기 ⇒
    sudo vi /etc/apt/sources.list.d/ubuntu.sources
    components 에 4가지 전부 되어있는데 무료만 쓰고 싶다면 main과 universe만 남기고 지운다

  apt install build-essential → c/c++ 컴파일러 관련 패키지
  hello.cpp 파일에 코딩 후 gcc -o hello hello.cpp 실행하면 hello 실행파일 생성.
  → hello 파일은 이진파일

  **env** 를 실행해보면 다양한 값 확인 가능. 그중 PATH

  ![image.png](attachment:558db08e-2c7b-4dc1-a6b2-8b2c9e7462aa:image.png)

  path는 경로를 다 입력하지 않고도 명령어를 실행할 수 있다.
  ex) /bin 폴더의 apt, cp, ls, mkdir, mv, rm, rmdir, sudo

  - pdf p.271 파일 압축과 묶기

    묶는 것은 압축과 다르다. 말그대로 묶는것. 압축보다 속도가 빠르다. ex) tar

    **tar 옵션**

    ![image.png](attachment:f3ca95d6-0f61-4706-9f98-4d3d753b91be:image.png)

    ![image.png](attachment:d0a2b9f0-9b9e-4824-a790-4a3f4ec53a6b:image.png)

  ### find - p.274-275

  find /home/kosa -name “my\*” → /home/kosa에서 my로 시작하는 파일 검색

  ![image.png](attachment:b666ca06-1c1b-45ae-ad93-2ce12120fbbd:image.png)

  ![image.png](attachment:725e4b2d-276f-4d5d-8608-cfe1ecd0d494:image.png)

  which, whereis, locate 도 있지만 find만 알면 된다.

  ### 방화벽 - p.277

  ufw

  ### cron (\*중요!!)

  주기적으로 반복되는 작업 예약. db에서 job 등록하는 것과 같음.
  기본적으로 root 권한으로 동작한다.

  systemctl status cron 으로 상태 확인

  ls /etc/cron\* ⇒

  ![image.png](attachment:8aedbf85-b810-4134-bf06-35663c82e511:image.png)

  sudo vi /etc/crontab

  ![image.png](attachment:2253d1dd-0631-405a-97f3-6d19ff8c0a53:image.png)

  ⇒ 1분마다, 시간, 일, 주, 년 은 상관없이 root 권한으로 다음 명령을 실행

  date >> /var/log/out.txt 이 명령어를 실행해서 tail -f 로 해당 명령어가 잘 실행되고 있는지 확인한다.
  tail -f 파일명 : 실시간으로 변경사항을 볼 수 있음

  ![image.png](attachment:c9392736-e804-40ea-9a73-3baabb0c1141:image.png)

  지금은 명령어가 한줄이지만 여러 줄 실행되도록 하고 싶으면 파일로 만들면 된다.

  ![image.png](attachment:45501d3c-8c95-4231-bfba-87f96e335f77:image.png)

  ⇒ 파일 생성 후 실행권한 부여

  ![image.png](attachment:1b7af6b9-cf9d-4a5a-8e74-48ab6693021d:image.png)

  ⇒ 명령을 바꾸고 싶다면 date.out.sh 파일을 바꾸면 된다.

  set $(date) # shell 구문 실행 후

  Thu Mar 12 07:44:01 UTC 2026
  $1 $2 $3 $4 $5 $6

  systemctl status cron : cron 상태확인

  - **at은 일회성 작업 예약 p.283**

    at -l : 등록된 작업 확인
    atrm 작업번호 : 해당 작업 삭제
    at 4:00 am tomorrow
    apt -y upgrade
    reboot
    ⇒ 실행할 명령어 다 입력했으면 ctrl + d
    cron과 마찬가지로 명령어 대신 sh 파일로 해서 파일 실행되도록 해도 됨.

  - **파이프 문자들**

    > : 파일로 출력 ex) echo Hello World > b.txt

    < : 입력 방향을 바꿈. ex) ssh-keygen -b 4096 < input_data : 앞의 명령어 실행했을때 입력해야할 내용들에 input_data 를 입력해줌. 입력 데이터.

    | :

    > > : 기존 파일 내용의 뒤에 덫붙여짐. ex) echo Hello World >> b.txt

- **20260313**

  ## **네트워크** p.285 - **네트워크 관련 작업을 할때는 반드시!! 설정파일 백업 or 스냅샷을 한다.**

  사설 ip

  ~.~.~.~/8,12,16,24 중 하나. 8→24 순의 크기. 8이 가장 크고 24가 가장 작음. 32-8. 2의24승. 32-24→ ip를 2의 8승개를 사용하는 것

  ~.~.~.255는 브로드캐스트 주소

  게이트웨이: 외부로 나가기 위한 통로. 게이트웨이 주소는 보통 마지막이 254,253,1 인 주소이지만 관리자가 임의로 설정 가능하다.

  넷마스크로 ip 범위 결정 가능? 요즘엔 잘 안쓰고 ~.~.~.~/8,16,… 표기법을 쓴다.

  네트워크 클래스라는 용어도 많이씀.

  A클래스는 맨앞의 3자리를 의미. A.B.C.D

  네트워크 주소(~.~.~.0), 브로드캐스트 주소(~.~.~.255), 게이트웨이 주소를 뺀 총 253대의 컴퓨터를 네트워크 내부에 연결 가능ip주소를 할당 가능

  p.288

  dns 주소 - url을 해당 컴퓨터의 ip주소로 변환해주는 서버 컴퓨터

  dns 서버(네임 서버)

  → 사설 - 윈도우 : C:\Windows\System32\drivers\etc\hosts
  → domain 이름으로 접속 도메인 정보 사설 정보로 hosts 파일에 설정함. 내 PC
  ex) ssh kosa@server1
  hosts 파일에 서버 ip가 설정되어있으면 C:\Users\KOSA_L3\.ssh\config 파일의
  Hostname을 해당 도메인 명으로설정해줄 수 있음

                  - 리눅스: /etc/hosts

  → 공개: dns 서버 주소 ex) 8.8.8.8

  p.288 의 리눅스에서의 네트워크 장치(ifupdown)은 볼 필요없음. 추후 proxmox ve를 진행할때는 활용할 예정.

  \***\*[network.md](http://network.md) 파일 참고!**

  1. /etc/network/interfaces 파일 설정 - 전통 방식
     sudo apt install ifupdown : 장치 관리 프로그램 다운
     ifdown 네트워크장치명 : 장치 정지
     ifup 장치명 : 장치 재가동
     if up/down을 하려면 /etc/network/interfaces 파일 설정 필요

  2)/etc/netplan/\*.yaml - 최신 방식(net plan)

  ![image.png](attachment:07023a89-fdd3-4cd5-aee3-302ea8952d32:image.png)

  sudo cat 50-cloud-init.yaml
  →

  ![image.png](attachment:5d681c54-4f4f-4a74-b1ba-fd8b2a02b2d2:image.png)

  윈도우에서는 처음

  윈도우 방화벽 → 고급설정 → 인바운드(내 컴퓨터로 들어오는것), 아웃바운드(내컴퓨터에서 나가는 것)

  상대방의 ping 을 막는 방법 - 아래의 3가지 항목의 사용을 아니요로 설정해놓으면 막힘. 사용함으로 변경하면 됨. **실제 운영하는 서비스 서버는 ping을 내린다.**

  ![image.png](attachment:a8212b0a-98e2-4d5c-931a-59d14c5f83fb:image.png)

  ![image.png](attachment:ceeb1f3f-7f16-408b-ae1b-b50b8e1d5797:image.png)

  **네트워크 관련 작업을 할때는 반드시!! 설정파일 백업 or 스냅샷을 한다.**

  우분투 리눅스 고정아이피 설정
  예전 방법과 달리 최근 방법은 netplan 폴더의 yaml 파일수정

  sudo vi 50-cloud-init.yaml
  ⇒

  network:
  version: 2
  renderer: networkd
  ethernets:
  ens32: # 인터페이스 이름
  dhcp4: no
  addresses:

  - 192.168.111.129/24 # 고정 IP/Subnet
    nameservers:
    addresses: [8.8.8.8]
    routes:
  - to: default
    via: 192.168.111.2 # 게이트웨이(공유기) IP

  수정후 다음의 명령어로 반영 : sudo netplan apply

  보통 ip 대역을 반으로 나눠 처음 절반(3~128)은 정적으로, 뒤의 절반(129~254)은 동적으로 사용한다. 여기에 실제 dhcp 대역을 설정해놓음

  ![image.png](attachment:633a8e6c-77ad-4f73-8ba3-a0fcb902da74:image.png)

  p.290

  nslookup : 도메인 서버의 작동여부 확인. 여기서 에러가 나면 **DNS 서버(전화번호부) 문제**거나 **도메인 설정 문제**

  /etc/resolv.conf : dns 서버 정보 및 호스트 이름이 들어있는 파일
  → 영구적으로 변경하려면 nm-connection-editor 또는 [nm.tui](http://nm.tui) 명령어로 수정하거나 /etc/netplan/\*.yaml 파일 수정하면 된다.

  /etc/hosts : 현 컴퓨터의 호스트 이름과 FQDN 이 들어있음.
  → 우분투 데스크탑서버에서 이파일에 nginx가 설치된 서버의 ip kosa-server
  이렇게 등록하면 파이어폭스로 http://kosa-server 에 연결 가능하다

  255.255.255.0 과 넷마스크 24는 동일하다.

  vmware 서버의 dns를 자신의 게이트웨이(192.168.111.2)로 설정하면 호스트 pc의 dns서버를 가져옴?

- **20260316**

  - **p.302 ~ 프로세스**

    윈도우의 **DLL**과 유닉스/리눅스의 **.so**는 프로그램 실행에 필요한 함수들을 모아놓은 **'공유 도서관(Shared Library)'**

    notepad a.txt 를 실행한 후 b.txt를 실행

    ⇒ 두번째 파일인 b.txt를 실행할땐 code는 a.txt 실행할때 올라온 것을 재활용하고 data만 올라온다.

    code는 공유데이터, 두 프로세스 안에서 실행을 담당하는 스레드. 스레드는 하나에 여러개가 있을 수 있다. 스레드 하나만 죽어도 프로세스가 죽는다. 그러나 다른 프로세스에는 영향을 미치지 않는다.

    스레드가 하나라도 죽으면 프로세스가 종료되기 때문에 프로세스를 나눔

    - **Code(프로그램)**: 메모리에 하나만 적재 / 여러 프로세스가 공유
    - **Data(문서 내용)**: 프로세스별 개별 할당 / 각자 별도로 존재
    - **스레드(실행 단위)**: 프로세스 내 존재 / 하나만 오류 나도 프로세스 전체 사망 (공동 운명체)
    - **프로세스(작업 단위)**: 독립된 메모리 공간 / 옆 프로세스가 죽어도 생존 (독립 생존)
    - **구조 설계**: 안정성을 위해 기능을 프로세스 단위로 분리 (위험 분산)

    ⇒ 공유데이터는 카운터, 또는 참조개수가 있다. 프로세스가 실행/종료될때마다 증가/감소되어 0이 되면 전체 메모리를 해제한다.

    ### VM vs Docker 구조 요약

    - **가상머신 (VM)**: OS 위에 OS를 또 올림 / 커널까지 통째로 분리 / 자원 소모 큼
    - **Docker (Container)**: 호스트 OS 커널 공유 / 실행 환경(Bin/Lib)만 격리 / 자원 소모 적고 가벼움
    - **Code(이미지)**: 읽기 전용으로 레이어 공유 / 여러 컨테이너가 같은 이미지 재사용
    - **Data(컨테이너 층)**: 컨테이너별 개별 생성 / 쓰기 가능 영역은 각자 별도로 존재
    - **구조적 이점**: 실행 속도 빠름 / 이식성 높음 / 호스트 OS 자원 효율적 활용

    ***

    ### 💡 보완 설명 (차이점)

    - **VM**은 하드웨어 수준의 가상화로 **'완전한 남'**처럼 동작하지만,
    - **Docker**는 프로세스 수준의 격리로 **'같은 지붕(커널) 아래 다른 방'**을 쓰는 것과 같습니다.

    ps aux : 리눅스/유닉스 시스템에서 현재 실행 중인 **모든 프로세스의 상태**를 확인하는 명령어
    pstree : 프로세스 간의 부모-자식 관계를 트리 구조로 시각화
    (sudo apt install psmisc 설치 필요)

    ![image.png](attachment:ef2a5e4b-d8bc-4240-8cbc-0ad9a745640d:image.png)

    → 3\* 이건 3개 실행중이라는 뜻. sshd 의 자식프로세스 두개.
    ps : 옵션없으면 부모 프로세스에 대한 정보만 나옴
    ps -ef : 전체 프로세스
    grep ssh ps.out : ps.out 파일에서 ssh를 찾음
    ps -ef | grep 프로세스명 : 필터링, |는 파이프문자
    kill -9 프로세스번호 : 강제종료

    ex) vi a.txt 를 실행하고 다른 터미널에서 ps -ef | grep vi를 실행하면 해당 프로세스가 실행중인 것을 확인할 수 있다.

    ![image.png](attachment:cd3e2b85-27ba-408e-a888-fe75cede0674:image.png)

    → 3번째는 부모프로세스 id.

    kill -9 7818 ⇒ 이렇게 강제종료하면 .a.txt.swp 파일이 생긴다.

    ![image.png](attachment:0edfbc29-f428-4af1-a48a-cd548431a0e7:image.png)

    .a.txt.swp를 지우지 않으면 a.txt를 열때 계속해서 경고문이 뜬다.
    수정중이었던 a.txt 파일을 열어서 Recover → 저장 → .swp 파일 삭제

    **p.303~**

    /dev/null - character, 출력도 입력도 안받는 장비. 이 장비에 뭔가 출력을 시도하면 콘솔화면에 아무것도 안뜸

    yes를 입력하면 y 를 무한대로 출력한다.

    yes > y.txt : y.txt에 y가 무한으로 쌓인다.

    ![image.png](attachment:f0414196-030e-4220-9eb1-8a90ee42edc3:image.png)

    ![image.png](attachment:b28a1b4f-945b-49ef-a791-0882185dbcc9:image.png)

    ![image.png](attachment:d56fde58-a901-4e0c-bf55-c99901df27d4:image.png)

    ![image.png](attachment:6de53495-9a0d-4f98-ae4f-0f1353cd2610:image.png)

    포그라운드 작업 → 백그라운드 → 포그라운드 로 변경
    ctrl + z : 작업 멈춤
    bg : 직전에 멈춘 작업을 백그라운드로 실행
    jobs : 작업 확인
    fg 작업번호 : 포그라운드로 실행
    명령어 & : 해당 명령어를 백그라운드로 실행

    ![image.png](attachment:6ed925e4-96da-46ff-a162-4977bcff2500:image.png)

    ![image.png](attachment:3f0c7c59-28b6-4e15-8b81-a013ba8dd5f6:image.png)

    ![image.png](attachment:1a1d373b-9aca-427a-9283-3f75d2b9d37c:image.png)

    p.306서비스 = 데몬 = 서버 프로세스 = 백그라운드 프로세스

  p.307~ 소켓

  소켓: 요청이 올때만 동작

  - **p.309~ 응급복구**

    - **root 비밀번호 분실했을때**

      1. 처음 시작시 esc, 혹은 방향키 누른다

      ![image.png](attachment:0faa9451-1e17-4936-b2d0-83aa1ad72d3f:image.png)

      → 이 화면에서 **e** 를 누른다. **원래 이 방법도 lock 걸 수 있다.**

      1. linux /vmlinuz … 줄의 맨 뒤로 커서 이동해서 init=/bin/bash를 추가한다

      ![image.png](attachment:f64a0f5a-8a2d-407a-868d-e21292624b80:image.png)

      → 수정후 ctrl+x 또는 f10으로 재부팅

      1. 바로 root 권한으로 진입됨. 그러나 mount 명령어 실행해보면 read only 상태인 것을 확인할 수 있다

      ![image.png](attachment:c6703068-1c08-47e1-85d5-f97af52eef5c:image.png)

      1. mount -o remount,rw /

      ![image.png](attachment:43924229-46a8-48df-9273-d5efc9ce7069:image.png)

      → 그 후 passwd 를 입력하면 비밀번호 정상적으로 변경되는 것을 확인할 수 있다.
      여기서는 현재 reboot 이나 shutdown 0 이 동작하지 않기 때문에 직접 restart
      **⇒ 위의 방법은 원격으로는 불가능하고 물리장비로 직접 접속시에만 가능하다. 위의 방법을 막는 방법 p.315~**

      **혹은**

      kosa 계정을 알고 있다면 sudo passwd 로 root의 비밀번호를 변경할 수 있다

      ![image.png](attachment:b320fc59-a354-4182-baf9-7b1f819030e6:image.png)

      동적모듈 - 서로 다른 프로세스 사이에 공통되는 라이브러리 공유
      ⇒ 맞는 표현인가? 윈도우 dll, unix so, …
      공유라이브러리

      - **루트 암호 모를때 변경 막는 방법(grub 활용)**

        /etc/grub.d/00_header를 수정하여 제일 아래에 다음의 4행을 추가

        ```bash
        cat << EOF
        set superuser="grubuser"
        password grubuser 1234
        EOF
        ```

        → update-grub 입력 후 재부팅

        ⇒

        편집모드로 들어갈때 사용자 이름과 비밀번호를 요구한다

        좀전에 설정한 grubuser를 정확히 입력해야 편집모드로 들어갈 수 있다

        부팅도 마찬가지로 grubuser가 필요함

  - **커널 p.317~**

    p.319 커널 업그레이드(속도를 위해 메모리 8GB, CPU 2x2 로 변경, 공간은 최소 40GB 이상이 필요)

    uname -r : 현재 커널 버전
    /usr/src 폴더에 다운된 소스 확인 가능
    다운받은 압축파일 압축해제 후 제대로 작동할지 검증이 필요
    make mrproper : 커널 설정 초기화
    make menuconfig : 커널 환경 설정 ( xwindow 환경에서는 make xconfig )
    make clean : 이전 정보 삭제
    make
    make modules_install
    make install
    ls -l /boot
    ⇒ 커널 컴파일 및 설치
    cat /boot/grub/grub.cfg : 부트로더 확인

    - 커널 업그레이드

      1.  root로 로그인
      2.  다운
          https://kernel.org/
          ⇒ 윈도우로 다운 후 scp 로 옮기던지,
          ⇒ tarball 우클릭, 링크복사 → 우분투 서버 cd /usr/src →
          wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.19.8.tar.xz
      3.  압축 풀기
          tar xfJ linux-6.19.8.tar.xz
      4.  컴파일을 위한 추가 프로그램 설치
          apt update
          sudo apt install build-essential libncurses-dev vim bc
          apt -y install make gcc g++ pkg-config qt6-base-dev flex bison libssl-dev libelf-dev
      5.  /usr/src/해당버전폴더로 이동→ 커널 설정 초기화(아무 메시지도 안나오는게 정상)
          make mrproper

              ![image.png](attachment:f9605cf0-2c9c-4b78-acea-05f0e24c35a3:image.png)

      6.  (되도록 생략하기)커널 환경 설정
          make menuconfig
          make xconfig - 데스크탑일때 사용 가능
      7.  컴파일시의 오류를 미리 방지하기 위해 다음을 실행

          ```bash
          # 초기 램 디스크(initrd) 지원을 먼저 켜기
          scripts/config --enable BLK_DEV_INITRD

          scripts/config --disable SYSTEM_TRUSTED_KEYS
          scripts/config --set-str SYSTEM_TRUSTED_KEYS ""
          scripts/config --disable SYSTEM_REVOCATION_KEYS
          scripts/config --disable SYSTEM_REVOCATION_KEYS ""
          # GZIP 압축 지원 활성화
          scripts/config --enable RD_GZIP
          scripts/config --enable DECOMPRESS_GZIP
          scripts/config --enable RD_ZSTD
          scripts/config --enable DECOMPRESS_ZSTD

          # 설정 파일 의존성 강제 업데이트 (이게 핵심!)
          make olddefconfig

          grep -E "BLK_DEV_INITRD|RD_GZIP|RD_ZSTD" .config
          ```

          위의 명령어 제대로 실행되었는지 확인
          grep CONFIG_SYSTEM_REVOCATION_KEYS .config
          → 명령어 결과가 빈값이면

      8.  이전 컴파일 정보 삭제(이전 작업한 기록이 없으면 실행하지 않아도 됨)
          make clean
      9.  다음의 명령 차례로 실행(설치 안되어있는 프로그램 추가 설치
          which 명령어로 확인가능)
          make -j$(nproc)  : 모든 CPU 코어 사용하여 make
            또는 time make -j$(nproc) : 실행 시간 출력해줌
          → make modules_install → make install
          (done 메시지 출력되면 완료된 것)
          ⇒ 용량 부족하면 expand(snapshot 있으면 expand 안됨)
      10. /lib/modules /boot 디렉토리에 해당 커널 버전 여부 확인
          ls -l /lib/modules
          ls -l /boot
      11. /boot/grub/grub.cfg 파일의 169행 즈음에 커널 버전 등록되어있는지 확인
      12. 재시작 - 커널 업그레이드 후에는 부팅 시 시간이 좀 오래 걸릴 수 있음
      13. uname -r 로 버전 확인
      14. 기존 커널이 없어진 것이 아니기 때문에 선택해서 부팅 가능
          재부팅 후 esc 버튼 클릭 →
          메뉴에서 Advanced options for Ubuntu 선택
          → 원하는 버전 선택 후 부팅 완료되면 uname -r 로 버전 확인

      ![image.png](attachment:18c9e019-65f0-461e-adc7-dc3baf660788:image.png)

    - 특정 버전 커널 삭제

      # 1. /boot 폴더의 관련 파일 삭제

      sudo rm -rf /boot/vmlinuz-6.19.8*
      sudo rm -rf /boot/initrd.img-6.19.8*
      sudo rm -rf /boot/System.map-6.19.8*
      sudo rm -rf /boot/config-6.19.8*

      # 2. 설치된 모듈 폴더 삭제

      sudo rm -rf /lib/modules/6.19.8/

      # 3. GRUB 설정 업데이트 (중요: 메뉴에서 항목을 지워줍니다)

      sudo update-grub

    h/w는 사람마다 차이가 있음

    \*.iso ⇒ 최적화되지 않은 일반적인 버전

    커널 컴파일 :

    - 나의 hw에 맞게 최적화된 상태로 실행될 수 있게 구성
    - 보안, 최신 장비, 미세한 버그 수정됨
    - 커널 / 모듈

  - **p.331~ 5장 X 윈도우 시스템** - 크게 중요하지는 않은 챕터

    sudo apt install gftp 설치

  윈도우에서 가장 많이 사용하는 ftp 서버 fzila. 지금은 설치x

- **20260317**

  - p.379~ 6장 하드디스크 관리와 사용자별 공간 할당

    메인보드에 존재하는 sata 포트

    - p.386~396 vmware에 하드 추가

      1.  vmware에서 새로운 하드를 추가

          ![image.png](attachment:49d0681b-a9c8-422e-8b2a-7ba19c54c4f2:image.png)

          우측 하단에 하드디스크 두개 떠있는것 확인 가능

          cd /dev → ls 에서 sdb 확인 가능 ( sda → sdb → sdc .. 이렇게 늘어남)

          ![image.png](attachment:9e5032f6-2b22-4b79-b115-fe7d7ca247e6:image.png)

      2.  파티션 나누기 → 파일시스템 사용 가능하도록 포멧 → mount
          /etc/fstab : mount 관리하는 파일. reboot를 해도 유지되도록

              ![image.png](attachment:324d29ad-02b8-4504-8e1b-0d8034a82735:image.png)

              이렇게 sdb 가 확인되는 상태

              1) fdisk /dev/sdb
              도움말 m 입력하면 명령어 볼 수 있음
              n :  새 분할 영역 추가
              p : 분할 영역 배치 출력
              d :  분할 영역 삭제
              w :  배치를 디스크에 기록하고 나가기

              ![image.png](attachment:155c4aea-44bf-4859-964d-26d3d652454e:image.png)

              n → default → default → default → default → p → w

              2) 디스크 포멧
              mkfs.ext4 /dev/sdb1

              3) mydata 폴더 만들기
              cd / → mkdir mydata

              4) 마운트 : mydata 폴더 밖에서 진행한다
              mount /dev/sdb1 /mydata : /mydata에 sdb1 마운트 ⇒ 기존 /mydata에 있던 데이터들은 보이지 않는다.

              5) 언마운트
              umount /dev/sdb1
              ⇒ 이제 다시 확인하면 다시 test.txt를 확인 가능
              ls -l /mydata

              6) reboot 이후에도 마운트 되어 있도록 설정하는 방법
              vi /etc/fstab
              → 마지막 줄에 다음 행 추가
              /dev/sdb1       /mydata ext4    defaults 0      0
              →reboot

    - p.396 하나의 하드디스크를 논리적으로 나눠서 사용하는 방법

      1. vmware에서 하드 디스크 추가
      2. ls /dev 로 장치 확인
      3. fdisk /dev/sdc : **장치명은 다를 수 있음을 유의!**

      ![image.png](attachment:0b5e2f63-f3ca-4312-accd-72362f64d21f:image.png)

      n → default → 1 → default → +2G (원하는 용량) →
      n → default → 2 → default → default (나머지 전부를 원하면) → p 로 확인 → w로 저장

      lsblk /dev/sdc : 용량 확인 가능

      1. 디스크 포멧
         mkfs.ext4 /dev/sdc1
         mkfs.ext4 /dev/sdc2
      2. 마운트
         mount /dev/sdc1 /disk1
         mount /dev/sdc2 /disk2

      df -h 로 확인 가능

    기존 파티션이나 레이드(RAID) 구성 정보를 깔끔하게 날리고 새 장치처럼 인식시키고 싶을 때 :
    wipefs -a /dev/sdc

    답변을 txt로 만들어서 fdisk /dev/sdc < sdc_layout.txt
    이렇게 실행하면 귀찮게 답변 안하고 일괄적으로 진행 가능

    - ↓↓↓sdc_layout.txt↓↓↓

      ```jsx
      o
      n
      p
      1

      +2G
      n
      p
      2

      w

      ```

    ⇒ 위 절차들을 shell 파일을 만들어서 한번에 쉽게 진행할 수도 있다. (shell 파일들은 실행권한 확인)

    - ↓↓↓make_sdc.sh↓↓↓

      ```bash
      wipefs -a /dev/sdc

      fdisk /dev/sdc < sdc_layout.txt

      mkfs.ext4 /dev/sdc1

      mkfs.ext4 /dev/sdc2

      mkdir /disk1
      mkdir /disk2

      mount /dev/sdc1 /disk1

      mount /dev/sdc2 /disk2

      cp /home/kosa/.bashrc /disk1/aaa

      cp /home/kosa/.bashrc /disk2/aaa

      ls /disk1
      ls /disk2

      echo '/dev/sdc1       /disk1  ext4   defaults 0 0' >> /etc/fstab
      echo '/dev/sdc2       /disk2  ext4   defaults 0 0' >> /etc/fstab

      ```

    - ↓↓↓clean_sdc.sh↓↓↓

      ```bash
      cd /
      umount /dev/sdc1
      umount /dev/sdc2

      rm -r /disk1
      rm -r /disk2

      ```

    - p.398 레이드 레벨

      레이드 방식 5개 (단순 볼륨은 레이드 방식에 포함x)
      Linear RAID, RAID 0, 1, 5, 6

      ***

      ### 🔵 주요 RAID 레벨 비교

      ### **1. RAID 0 (Striping)**

      - **원리:** 데이터를 여러 디스크에 분산해서 나누어 저장
      - **장점:** 읽기/쓰기 속도 극대화 (디스크 개수만큼 배가됨)
      - **단점:** **결함 허용(Fault Tolerance) 없음**. 디스크 1개만 고장 나도 전체 데이터 손실
      - **용도:** 고성능이 필요하지만 데이터 중요도가 낮은 작업 (임시 작업장 등)

      ### **2. RAID 1 (Mirroring)**

      - **원리:** 두 개의 디스크에 동일한 데이터를 동시에 똑같이 저장 (복사본)
      - **장점:** 안정성 최상. 디스크 하나가 죽어도 데이터 보존 및 즉시 복구 가능
      - **단점:** 비용 효율 절반 (50%). 2TB 하드 2개를 써도 실제 사용 공간은 2TB뿐
      - **용도:** OS 부팅 디스크, 중요 문서 보관

      ### **3. RAID 5 (Striping with Parity)**

      - **원리:** 데이터를 분산 저장하되, 오류 복구용 정보(**Parity**)를 각 디스크에 나누어 저장
      - **최소 디스크:** 3개 이상 필요
      - **장점:** 성능, 용량, 안정성의 균형. 디스크 **1개** 고장까지는 버팀
      - **단점:** 쓰기 시 패리티 계산으로 인한 성능 저하 발생
      - **용도:** 일반적인 서버 및 NAS 구성

      ### **4. RAID 6 (Striping with Double Parity)**

      - **원리:** RAID 5와 비슷하지만 패리티 정보를 **2중**으로 저장
      - **최소 디스크:** 4개 이상 필요
      - **장점:** 디스크 **2개**가 동시에 고장 나도 데이터 안전
      - **단점:** RAID 5보다 쓰기 속도가 더 느리고 가용 용량이 줄어듦
      - **용도:** 대용량 스토리지, 데이터 보존이 극도로 중요한 환경

      ### **5. RAID 10 (1+0, Mirrored Stripes)**

      - **원리:** RAID 1(미러링)로 묶은 그룹들을 다시 RAID 0(스트라이핑)으로 묶는 방식
      - **최소 디스크:** 4개 이상 (짝수)
      - **장점:** RAID 0의 속도 + RAID 1의 안정성을 모두 가짐 (성능 최강)
      - **단점:** 비용이 매우 비쌈 (전체 용량의 50%만 사용 가능)
      - **용도:** 고성능 DB 서버

      ***

      ### 📊 요약 테이블

      | **구분**    | **최소 디스크** | **가용 용량** | **특징**                        |
      | ----------- | --------------- | ------------- | ------------------------------- |
      | **RAID 0**  | 2               | 100%          | **속도** 몰빵, 안정성 0         |
      | **RAID 1**  | 2               | 50%           | **안정성** 몰빵, 비용 높음      |
      | **RAID 5**  | 3               | N-1           | 효율적인 밸런스 (1개 장애 허용) |
      | **RAID 6**  | 4               | N-2           | 높은 안정성 (2개 장애 허용)     |
      | **RAID 10** | 4               | 50%           | **속도 + 안정성** (고가형)      |

      ***

    - p.408 레이드 실습(실습 분량 많음)

          1GB 하드디스크 2개를 추가 후 실습 (레이드를 할땐 하드디스크 용량이 동일해야함)

          fdisk /dev/sdb
          n → p → 1 → default → default → t (파일시스템 유형 선택) → fd(Linux raid autodetect)
          → p

          ![image.png](attachment:c6a4cdc7-1c88-466e-9fda-29a11f764349:image.png)

          → w
          fdisk /dev/sdc 도 동일하게 진행

          - /dev/sdb1 과 /dev/sdc1 을 RAID 0 장치인 /dev/mdo으로 생성 (mdadm : RAID 관리도구)
            mdadm --create /dev/md0 --level=0 --raid-devices=2 /dev/sdb1 /dev/sdc1 : 생
            mdadm --detail --scan : 확인
          - man 명령어(manual) 사용(번외. 필요없지만)
            apt install man-db
            unminimize
            man mdadm
          - 포멧
            mkfs.ext4 /dev/md0
          - 마운트할 폴더 생성하고 마운트
            mkdir /raid0
            mount /dev/md0 /raid0
          - 상태 확인
            df -h
          - 재부팅해도 다시 마운트 안해도 되게끔 설정
            vi /etc/fstab
            마지막 줄에 다음 행 추가
            /dev/md0 /raid0 ext4 defaults 0 0
          - /etc/fstab 변경사항 바로 적용되는 명령어(재부팅 안해도 됨)
            systemctl daemon-reload
          - /etc/fstab에 등록된 설정대로 마운트를 실행하고 싶다면
            mount -a

          - 삭제절차(아직 안해봄)

            RAID 구성을 해제하고 디스크를 초기 상태로 돌리는 과정은 LVM보다 조금 더 까다롭습니다. RAID 장치가 활성화된 상태에서 단순히 파티션만 지우면 나중에 다시 RAID 정보가 살아나서 시스템을 괴롭힐 수 있거든요.

            아래 **5단계**를 차근차근 따라 하시면 깨끗하게 삭제됩니다.

            ***

            ### 1단계: 마운트 해제 및 설정 파일 원복

            가장 먼저 사용 중인 연결을 끊고 자동 마운트 설정을 지워야 합니다.

            - **마운트 해제:**Bash

              #

              `umount /raid0`

            - **`/etc/fstab` 수정:**

              `vi /etc/fstab`에서 `/dev/md0` 관련 줄을 **삭제**하거나 `#`으로 주석 처리하세요.

            - **설정 반영:**Bash

              #

              `systemctl daemon-reload`

            ### 2단계: RAID 장치 중지 (Stop)

            현재 작동 중인 가상 디스크(`md0`)를 멈춰야 합니다.

            Bash

            #

            `mdadm --stop /dev/md0`

            > **확인:** `lsblk`를 입력했을 때 `md0`라는 이름이 사라졌는지 확인하세요.

            ### 3단계: 디스크 내부의 RAID 슈퍼블록 제거 (가장 중요!)

            디스크(`sdb1`, `sdc1`)에는 "나는 RAID의 일원이야!"라는 정보(Superblock)가 저장되어 있습니다. 이걸 지워야 일반 디스크로 돌아옵니다.

            Bash

            #

            `mdadm --zero-superblock /dev/sdb1

      mdadm --zero-superblock /dev/sdc1`

            - 만약 `wipefs`를 알고 계신다면, 여기서 한 번 더 깔끔하게 밀어버려도 좋습니다:

              `wipefs -a /dev/sdb1 /dev/sdc1`

            ### 4단계: 파티션 삭제 및 초기화

            이제 `fdisk`에서 만들었던 파티션(`fd` 타입)을 삭제합니다.

            1. `fdisk /dev/sdb` 실행 후 → **`d`** (삭제) → **`w`** (저장)
            2. `fdisk /dev/sdc` 실행 후 → **`d`** (삭제) → **`w`** (저장)

            ### 5단계: RAID 관리 파일 정리

            시스템이 부팅될 때 RAID를 찾으려고 시도하지 않도록 관리 파일을 확인합니다. (파일이 없을 수도 있습니다.)

            - `/etc/mdadm/mdadm.conf` 파일이 있다면, 안에 적힌 `ARRAY /dev/md0 ...` 관련 내용을 삭제해 주세요.

            ***

            ### ✅ 최종 확인

            모든 작업이 끝난 후 아래 명령어로 확인했을 때 아무런 RAID 정보가 나오지 않아야 합니다.

            Bash

            #

            `mdadm --detail --scan   # 아무 결과도 없어야 정상

      lsblk # sdb, sdc가 파티션 없이 깨끗하게 보여야 정상`

            **팁:** 만약 나중에 이 하드들을 다시 사용하려고 할 때 "이미 RAID의 일부였다"는 경고가 뜬다면, **`3단계`**의 `zero-superblock` 명령어를 한 번 더 실행해 주시면 해결됩니다.

            이제 디스크가 처음 샀을 때처럼 깨끗해졌습니다! 다음엔 어떤 구성을 해보실 계획인가요? 무엇이든 물어보세요! :)

    - p.454 LVM

          실습

          1.  3GB, 2GB 추가
          2.  ls /dev/sd\* 로 확인 후 fdisk /dev/sd? 실행
              hex code는 8e (linux LVM)으로 설정
          3.  물리 볼륨 생성
              pvcreate /dev/sdb1
              pvcreate /dev/sdc1
          4.  2개의 물리 볼륨 묶기
              vgcreate myVG /dev/sdb1 /dev/sdc1
          5.  볼륨 그룹 확인
              vgdisplay
          6.  논리 그룹 1GB/3GB/1GB로 나누기
              lvcreate --size 1G --name myLG1 myVG
              lvcreate --size 3G --name myLG2 myVG
              lvcreate --extents 100%FREE --name myLG3 myVG
          7.  폴더 및 상태 확인
              ls -l /dev/myVG

                  ![image.png](attachment:7b24958b-bd49-47e6-abe1-b93b306043d5:image.png)

          8.  파일시스템 생성(포멧)
              mkfs.ext4 /dev/myVG/myLG1
          9.  폴더 생성 후 mount
              mkdir /lvm1 ~ mkdir /lvm3
              mount /dev/myVG/myLG1 /lvm1
              ~ mount /dev/myVG/myLG3/lvm3
          10. mount 자동으로 되도록 설정
              vi /etc/fstab 실행후 아래 행 추가
              /dev/myVG/myLG1 /lvm1 ext4 defaults 0 0
              /dev/myVG/myLG2 /lvm2 ext4 defaults 0 0
              /dev/myVG/myLG3 /lvm3 ext4 defaults 0 0

          systemctl daemon-reload 실행

          - **삭제절차**

            LVM(Logical Volume Manager)은 생성할 때의 **역순**으로 차근차근 제거해야 에러 없이 깔끔하게 지워집니다. 마운트 해제부터 물리 디스크 초기화까지의 과정을 정리해 드릴게요.

            ***

            ### 1. 마운트 해제 및 설정 삭제

            가장 먼저 사용 중인 디스크를 안전하게 분리합니다.

            - **마운트 해제:**Bash

              `umount /lvm1 /lvm2 /lvm3`

            - **`/etc/fstab` 수정:**

              `vi /etc/fstab`에 접속해서 추가했던 3줄을 삭제하거나 주석(`#`) 처리하세요. (안 그러면 나중에 부팅 시 에러가 날 수 있습니다.)

            - **설정 반영:**Bash

              `systemctl daemon-reload`

            ***

            ### 2. LVM 구성 요소 삭제 (역순 처리)

            **논리 볼륨(LV) → 볼륨 그룹(VG) → 물리 볼륨(PV)** 순서로 삭제합니다.

            - **LV(Logical Volume) 삭제:**Bash

              `lvremove /dev/myVG/myLG1
              lvremove /dev/myVG/myLG2
              lvremove /dev/myVG/myLG3

              # 한꺼번에 지우려면: lvremove myVG`

            - **VG(Volume Group) 삭제:**Bash

              `vgremove myVG`

            - **PV(Physical Volume) 삭제:**Bash

              `pvremove /dev/sdb1 /dev/sdc1`

            ***

            ### 3. 디스크의 LVM 흔적 지우기 (Wipe)

            아까 물어보셨던 `wipefs`가 여기서 활약합니다. 파티션 테이블에 남은 LVM 정보를 완전히 날려줍니다.

            Bash

            `wipefs -a /dev/sdb

      wipefs -a /dev/sdc`

            ***

            ### 4. 파티션 삭제 (선택 사항)

            만약 `/dev/sdb1` 같은 파티션 자체도 없애고 싶다면 `fdisk`를 사용합니다.

            1. `fdisk /dev/sdb` 실행
            2. `d` 입력 (Delete partition)
            3. `w` 입력 (Save)

            - `/dev/sdc` 도 동일하게 진행하세요.

            ***

            ### ✅ 최종 확인

            모든 흔적이 사라졌는지 확인합니다.

            Bash

            `lvs     # 아무것도 안 떠야 함

      vgs # 아무것도 안 떠야 함
      pvs # 아무것도 안 떠야 함
      lsblk # sdb, sdc가 마운트 포인트 없이 깨끗한 상태인지 확인`

            **주의:** 이 작업을 마치면 안에 있던 데이터는 모두 날아갑니다! 이미 마운트를 해제하셨으니 괜찮으시겠지만, 혹시 중요한 파일이 있다면 미리 백업했는지 확인해 보세요.

            더 궁금하신 점이나 막히는 단계가 있나요?

![image.png](attachment:506e8787-c21f-429a-941d-5cc0d29fa37d:image.png)

⇒ 20260317 숙제

- 20260318

  - p.471~ 쉘

    - 쉘

      쉘 - 사용자가 입력한 명령을 해석해 커널로 전달. 커널의 처리결과를 사용자에게 전달

      sh - 쉘의 가장 기본 프로그램. 기본은 같다. 스크립트만 조금 다름

      환경변수의 크기는 4k

      bash 는 sh가 확장된 프로그램

      ~/.bashrc , ~/.profile 이 두 파일이 사용자 환경변수. 윈도우의 사용자 변수와 같음.
      .bashrc 내용에
      alias l='ls -CF’
      ⇒ 명령을 줄여서 사용할 수 있도록 설정

      /etc/profile - 윈도우의 시스템 변수로 생각하면 됨

      export 환경변수=값 : 환경변수 변경

      printenv : 환경변수 출력. 그냥 env 쳐도 나옴

      echo $환경변수명 : 환경 변수 값 확인

    p.473~ 쉘 스크립트 프로그래밍 실습

    - 쉘 파일 실행(~p.476)

      .sh는 안써도 되지만 알리는 목적으로 쓴다.

      ↓↓↓ name.sh ↓↓↓

      ```bash
      #!/bin/sh
      echo "Hello World!"
      echo "인프라 과정"
      exit 0
      ```

      - 실행방법 두가지

      1. sh name.sh
      2. chmod +x name.sh → ./name.sh

      실행권한을 줘도 그냥 [name.sh](http://name.sh) 입력했을때 실행 안되는 이유 : PATH에 pwd 가 추가 안되었고, . 도 추가 안되었기 때문

      vi .bashrc → 아래의 내용을 마지막 행 뒤에 추가한다

      ```bash
      PATH=$PATH:/home/kosa
      echo $PATH
      ```

      → $PATH는 PATH 가 가지고 있던 원래값을 전달하는 역할

      /home/kosa 에서는 [name.sh](http://name.sh) 실행이 되지만 이 경로를 벗어나면 여전히 안됨

      → vi ~/.bashrc 를 다음과 같이 수정

      ```bash
      export PATH=$PATH:.
      ```

      source .bashrc : . .bashrc와 동일 ⇒ 실행하면 뒤에 계속 /home/kosa가 늘어남

    - 변수(p.476~

      ![image.png](attachment:80fc02db-79e3-41ba-8a9e-5a7154b05446:image.png)

      - echo \$myvar : $ 문자가 들어간 글자 출력을 위해 \ 가 필요
      - 백틱 ` 을 붙여주고 expr 을 쓰면 연산 가능. 연산자 앞뒤로 띄어쓰기 필요
      - echo ‘$myvar’ : myvar를 문자열로 인식
      - echo “$myvar”: 변수 myvar 출력. “ 없어도 됨
      - 파라미터 변수

        ![image.png](attachment:44aa1402-c85a-4626-a0ce-7f8d87b5edd9:image.png)

        ![image.png](attachment:974d396b-d1f8-4897-95de-0c6602684b09:image.png)

    - if 문과 case 문(p.480~)

      - if 문 - 공백 주의!

        ![image.png](attachment:4a0b9ad0-ffd3-4dc3-8626-0e1ac9f09c0e:image.png)

      - if~else 문

        ![image.png](attachment:1ae5a492-8795-48ac-bea5-c758eda22f40:image.png)

      - 비교 연산자

        ![image.png](attachment:49a7a89b-9a46-43c1-bab9-2f63f4cf1d90:image.png)

      - 산술 비교 연산자

        ![image.png](attachment:ec8396e0-4c9f-4875-b022-43077e9ac2cd:image.png)

      - 파일 조건

        ![image.png](attachment:ae8b910c-0cbd-46c0-9cf2-b76ccf4e4911:image.png)

      - p.485~ case~esac 문

        ex)

        ![image.png](attachment:7497e2ef-3b26-4d2b-a2a3-b01c00818266:image.png)

      - p.487~ AND OR 관계 연산자

        and 는 -a 또는 && 사용, or는 -o 또는 || 사용. -a, -o는 테스트문([ ]) 안에서 사용 가능

    - 반복문(p.488~

      - p.489 for~in문

        do 안의 반복할 문장을 실행

        ex)

        ![image.png](attachment:c435dc54-2cbf-4192-828d-cc662e09081f:image.png)

        ex) 달러 안쪽은 쉘 구문

        ![image.png](attachment:c17c4eac-b323-4917-bcbd-80db459cc745:image.png)

      - p.491 while문

        조건식 위치에 [ 1 ] 또는 [ : ] 는 항상 참

        ![image.png](attachment:5bf2b084-d9e0-488f-abf0-b9f261818787:image.png)

      - p.493 until 문
        - 조건이 참일 때까지(거짓인 동안) 계속 반복
      - break, continue, exit, return

        ![image.png](attachment:8d8d1178-f477-44cb-8008-253e15ded856:image.png)

    - 함수(p.495~

      - 함수 파라미터

        ![image.png](attachment:78e51913-68ac-4251-87e6-a34491d0cc62:image.png)

      - eval 함수 - 문자열을 명령문으로 인식하여 실행

        ![image.png](attachment:20ce3017-0cfd-41be-bf74-36e6228bfc12:image.png)

      - export 함수 - 외부 변수로 선언해줌. 선언한 변수를 다른 프로그램에서도 사용 가능해짐

        ![image.png](attachment:8e50e189-2a80-42b3-a9d9-f2b1161980d4:image.png)

        ![image.png](attachment:1d55bbfb-497d-4bc0-a1b7-ea400994e14e:image.png)

      - printf - c언어 printf 와 비슷하게 형식 지정하여 출력 가능

        ![image.png](attachment:b6040b9b-5f81-4ef7-84c6-ce01d0526840:image.png)

        ![image.png](attachment:85302244-9dd2-4754-90d8-6fb876a133d5:image.png)

      - set 과 $ - 리눅스 명령을 결과로 사용하려면 $(명령) 형식을 사용해야함. 결괄ㄹ 파라미터로 사용할 때는 set과 함께 사용

        ![image.png](attachment:ae6d8052-c686-4b39-a1f1-7b3de382a7ec:image.png)

        **\*참고:** $0은 변경 안됨(실행파일명)

      - shift - 파라미터 변수를 왼쪽으로 한단계씩 아래로 시프트(이동)시킴

        AAA BBB CCC → BBB CCC → CCC 이렇게 왼쪽으로 한단계씩 시프트하는것

        ![image.png](attachment:5b71a1c6-1320-4d5e-a017-5e6409e0f50f:image.png)

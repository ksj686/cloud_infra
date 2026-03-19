- WSL
    
    **WSL**은 **Windows Subsystem for Linux**의 약자로, **Windows 안에서 Linux를 직접 실행할 수 있게 해주는 기능**입니다. 쉽게 말해 **Windows를 쓰면서도 Linux 환경을 동시에 사용할 수 있게 하는 기술**입니다. 🖥️🐧
    
    ---
    
    # 1️⃣ WSL이 등장한 이유
    
    예전에는 Windows에서 Linux를 쓰려면 보통 다음 방법을 사용했습니다.
    
    - **듀얼 부팅**: 컴퓨터 켤 때 Windows / Linux 선택
    - **가상 머신**: VirtualBox나 VMware 같은 프로그램으로 Linux 실행
    
    하지만 이런 방식은 문제가 있었습니다.
    
    - 설정이 복잡함
    - 성능 손실이 있음
    - 파일 공유가 번거로움
    
    그래서 Microsoft가 **Windows 안에서 Linux를 네이티브처럼 실행하는 기능**을 만들었고 그것이 **WSL**입니다.
    
    ---
    
    # 2️⃣ WSL의 핵심 개념
    
    WSL은 **Linux 커널과 사용자 공간을 Windows 위에서 실행**하게 합니다.
    
    즉 다음 구조입니다.
    
    ```
    Windows
     └ WSL
         └ Linux 배포판 (Ubuntu, Debian 등)
             └ bash, apt, gcc, python 등
    ```
    
    그래서 Windows 안에서 다음 같은 **Linux 명령어를 그대로 사용**할 수 있습니다.
    
    ```bash
    ls
    grep
    apt install
    ssh
    git
    ```
    
    대표적으로 설치 가능한 Linux 배포판:
    
    - Ubuntu
    - Debian
    - Kali Linux
    - openSUSE
    
    ---
    
    # 3️⃣ WSL1 vs WSL2 차이
    
    WSL에는 두 가지 버전이 있습니다.
    
    | 구분 | WSL1 | WSL2 |
    | --- | --- | --- |
    | 방식 | Windows 커널에서 Linux 시스템 호출 번역(**direct가 아닌 indirect. 느림**) | 실제 Linux 커널 사용 |
    | 속도 | 빠른 파일 접근 | 더 빠른 Linux 성능 |
    | 호환성 | 일부 프로그램 제한 | 거의 완전한 Linux |
    | Docker 지원 | 제한적 | 완전 지원 |
    
    현재는 대부분 **WSL2 사용**합니다.
    
    ---
    
    # 4️⃣ WSL2의 내부 구조
    
    WSL2는 내부적으로 **가벼운 가상 머신**을 사용합니다.
    
    구조:
    
    ```
    Windows
     └ Hyper-V 기반 경량 VM
         └ Linux Kernel
             └ Ubuntu / Debian 등
    ```
    
    여기서 사용하는 기술은:
    
    - Hyper-V
    - 실제 Linux Kernel (Microsoft 제공)
    
    하지만 사용자는 **VM을 직접 관리할 필요가 없습니다.**
    
    ---
    
    # 5️⃣ WSL의 주요 장점
    
    ### 1. 개발 환경에 최적
    
    많은 개발 도구가 Linux 중심입니다.
    
    예:
    
    - Docker
    - Node.js
    - Python
    - Git
    
    WSL을 쓰면 **Linux 개발환경을 Windows에서 그대로 사용 가능**합니다.
    
    ---
    
    ### 2. Windows와 파일 공유
    
    WSL에서는 Windows 파일에 바로 접근할 수 있습니다.
    
    예:
    
    ```
    /mnt/c/Users/username/Desktop
    ```
    
    즉
    
    - Windows 파일
    - Linux 파일
    
    둘 다 동시에 사용 가능
    
    ---
    
    ### 3. 터미널 통합
    
    WSL은 다음 터미널과 잘 연동됩니다.
    
    - Windows Terminal
    - PowerShell
    
    그래서 하나의 터미널에서:
    
    ```
    Ubuntu
    PowerShell
    CMD
    ```
    
    모두 사용할 수 있습니다.
    
    ---
    
    # 6️⃣ WSL에서 가능한 것
    
    WSL을 사용하면 다음이 가능합니다.
    
    ✔ Linux 서버 개발
    ✔ Docker 컨테이너 실행
    ✔ Python 데이터 분석
    ✔ Node.js 웹 개발
    ✔ Git 사용
    ✔ SSH 서버 접속
    ✔ Linux CLI 도구 사용
    
    또한 최근에는 **Linux GUI 프로그램도 실행 가능**합니다.
    
    예:
    
    - Visual Studio Code (WSL 연동)
    - Linux GUI 앱
    
    ---
    
    # 7️⃣ 설치 방법 (요약)
    
    Windows 10/11에서는 **한 줄로 설치**할 수 있습니다.
    
    ```powershell
    wsl --install
    ```
    
    그러면 자동으로:
    
    - WSL
    - Linux Kernel
    - Ubuntu
    
    설치됩니다.
    
    ---
    
    # 8️⃣ WSL이 특히 많이 쓰이는 분야
    
    WSL은 다음 분야에서 많이 사용됩니다.
    
    **개발자**
    
    - 웹 개발
    - 백엔드 개발
    - 클라우드 개발
    
    **보안**
    
    - Kali Linux 기반 보안 테스트
    
    **데이터**
    
    - Python 데이터 분석
    
    ---
    
    # 9️⃣ WSL vs 전통 Linux
    
    | 항목 | WSL | Linux PC |
    | --- | --- | --- |
    | 설치 난이도 | 매우 쉬움 | OS 설치 필요 |
    | 성능 | 거의 동일 | 완전 동일 |
    | Windows 프로그램 | 같이 사용 가능 | 불가능 |
    | 서버 운영 | 제한적 | 적합 |
    
    ---
    
    ✅ **한 줄 정리**
    
    > **WSL은 Windows 안에서 Linux를 거의 네이티브 성능으로 실행할 수 있게 해주는 개발 환경 기술입니다.**
    > 
    
    ---
    
    원하시면 제가 추가로 설명해 드릴게요:
    
    - **WSL이 개발자에게 인기 있는 이유 (진짜 핵심)**
    - **WSL + Docker + VS Code 개발 환경 구조**
    - **WSL 내부 구조 (커널 / VM / 파일 시스템)**
    - **WSL을 쓰면 좋은 사람 vs 쓰지 말아야 할 사람** 🚀

- 설치
    
    https://web-yiyeon.tistory.com/12
    
    (링크에 다 포함되어있는 내용들)
    
    작업 관리자 → 성능 탭에서 `가상화 : 사용` 안되어있으면 설정 변경해야한다. gui 에서 설정 찾기 어려우면 터미널에서 명령어로 특성 활성화 가능
    
    터미널 관리자 권한으로 실행 후 아래 명령어 실행
    
    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
    
    wsl 설치
    
    wsl --install
    
    시스템 재시작 필요
    
    wsl.exe --list --online
    =(아래 명령어와 같음)
    wsl -l -o
    리스트 중 Ubuntu-24.04 설치하기로 함
    
    wsl --install -d Ubuntu-24.04 
    -d옵션은 실행까지
    
    혹시 중간에 에러나면 설치과정 정리된 링크에 들어가서 그대로 진행하기
    
    - Linux 커널 업데이트 패키지 다운로드
    - wsl -d Ubuntu-24.04 실행했는데 안뜨는 경우⇒ 직접 윈도우 검색에 ubuntu 입력해서 직접 실행,또는 터미널에서 직접 실행 가능
    
    ![image.png](attachment:82aa47cf-24d3-42a8-9931-bb505ede951b:image.png)
    
    그래도 안되면  제거하고 다시 설치
    

wsl2 우분투 계정

id: kosa

pw: kosa1004

- wsl 명령어
    
    wsl 설치
    
    wsl --install
    
    시스템 재시작 필요
    
    wsl.exe --list --online
    =(동일)
    wsl -l -o
    ⇒ -o 는 온라인, -l 만 있으면 현재 pc 에 설치된 리스트만 나옴
    리스트 중 Ubuntu-24.04 설치하기로 함
    
    wsl --install -d Ubuntu-24.04 
    -d옵션은 실행까지
    
    wsl -l -v 현재 설치된 list 및 버전
    NAME            STATE           VERSION
    
    * Ubuntu-24.04 Stopped 2
    
    wsl --help 로 명령어 검색
    
    wsl --unregister Ubuntu-24.04 ⇒ 설치된 해당 버전 우분투 제거됨
    

- 리눅스 명령어
    
    cd
    
    ⇒ 현재 계정에서 작업할 수 있는 폴더로 이동
    
    kosa@KOSA:~$ 
    ⇒
    - 마지막에 $가 오면 일반계정, #은 관리자계정
    - 계정명@PC명:경로
    - ~: 현재 로그인 사용자의 작업폴더. = /home/계정명
    
    pwd ⇒ 현재 작업 폴더의 절대 경로 출력
    
    cd ⇒ 작업 폴더 변경
    - . 은 현재 위치, ..는 부모폴더, / 는 최상위 root경로
    
    mkdir 폴더명 ⇒ 폴더 생성
    mkdir 상위/하위폴더명 ⇒ 반드시 부모가 존재해야 하위 폴더가 생성됨
    mkdir -p 상위/하위폴더명 ⇒  -s 옵션을 지정하면 상위폴더 없는 경우 상위폴더가 먼저 만들어지고 하위 폴더가 생성됨
    
    kosa@KOSA:~$ ls -la bbb ⇒ 폴더 구조 보여줌
    total 12
    drwxr-xr-x 3 kosa kosa 4096 Mar  5 17:36 .
    drwxr-x--- 4 kosa kosa 4096 Mar  5 17:37 ..
    drwxr-xr-x 2 kosa kosa 4096 Mar  5 17:36 ccc
    
    rmdir  폴더명  ⇒ 폴더 삭제(폴더가 비어있지 않으면 삭제 안됨)
    

- 윈도우 파워쉘
    
    / \ 둘다 먹음
    
    cd \ 또는cd / ⇒ 최상위로 이동
    
    cd ~ ⇒ 사용자폴더로 이동
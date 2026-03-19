- 20260309
    
    http://서버주소
    
    웹서버종류
    아파치웹서버, nginx
    
    아직 점유율은 아파치가 많지만 새로운 서비스는 nginx로 많이 시작하는 편이다.
    
    웹서버는 일반 프로그램이 아닌 서비스 프로그램이다.
    
    **서비스 프로그램**은 컴퓨터가 전원이 켜지면 부팅 후 자동으로 실행되는 프로그램. **백그라운드 프로그램**이라고도 한다.
    
    **서비스 프로그램 관리 방법 - alpine linux는 systemctl 관련 명령어 없음**
    1. 컴퓨터 전원이 켜지면 자동 실행
      sudo systemctl enable 서비스명
    2. 서비스 프로그램을 실행 중 종료할 수 있음
      sudo systemctl stop 서비스명
      sudo service 서비스명 stop
    3. 종료된 서비스 프로그램을 실행할 수 있음
      sudo systemctl start서비스명
      sudo service 서비스명 start
    4. 실행 중인 서비스 프로그램 다시 실행할 수 있음
      sudo systemctl restart 서비스명
      sudo service 서비스명 restart 
    5. 컴퓨터 전원이 켜져도 서비스가 실행되지 않도록 설정 가능
      sudo systemctl disable 서비스명
    6. 서비스 상태 확인 방법
      sudo systemctl status 서비스명
      sudo service 서비스명 status
    
    root@kosa-server:/home/kosa# service nginx status
    ● nginx.service - A high performance web server and a reverse proxy server
    Loaded: loaded (/usr/lib/systemd/system/nginx.service; enabled; preset: enabled)
    Active: active (running) since Mon 2026-03-09 05:47:00 UTC; 39min ago
    
    loaded 부팅시 실행여부. enabled는 실행된다는 뜻.
    
    Active는 현재 실행중인지
    
    - nginx설치
        - 우분투에 설치
            
            sudo apt install nginx
            
        
        - alpine linux에 설치 - systemctl 관련 명령어 없음
            
            su - # root로 변경
            
            …#  apk add nginx
            
            service nginx status : 상태 확인. ubuntu와는 달리 설치 후 자동 실행 안됨.
            
            service nginx start : 실행. ip 주소로 인터넷 창 열어보면 404 페이지 뜸.(문서가 없기 때문)
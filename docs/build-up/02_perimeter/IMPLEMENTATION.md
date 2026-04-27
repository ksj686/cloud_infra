# Implementation Guide: Phase 2 Perimeter

본 문서는 Phase 2 네트워크 경계 보안 및 트래픽 제어 구성을 위한 상세 명령어 및 설정 파일 명세 정리

---

## 1. Nginx 리버스 프록시 및 로드 밸런싱

### 1.1 Nginx 설치 및 기본 구성

```bash
sudo apt update && sudo apt install nginx -y

# 업스트림 및 가상 호스트 설정
sudo vi /etc/nginx/sites-available/cloud-infra
```

```yaml
# /etc/nginx/sites-available/cloud-infra
upstream backend_servers {
server 192.168.100.11:80 max_fails=1 fail_timeout=10s;
server 192.168.100.12:80 max_fails=1 fail_timeout=10s;
}

server {
    listen 80;
    server_name api.kosa.kr;

    # L7 경로 기반 라우팅 (Ingress 개념 적용)
    location /api/v1 {
        proxy_pass http://backend_servers;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    location /static {
        alias /usr/share/nginx/html/static;
        expires 30d;
        access_log off;
    }

    location / {
        proxy_pass http://frontend_servers;
        proxy_set_header Host $host;
    }
}

```

```bash
# 설정 활성화 및 테스트
sudo ln -s /etc/nginx/sites-available/cloud-infra /etc/nginx/sites-enabled/
sudo nginx -t && sudo systemctl restart nginx
```

---

## 2. HTTPS 사설 레지스트리 (Docker Registry v2)

### 2.1 인증서 생성 (자가 서명)

```bash
mkdir -p ~/registry/certs
openssl req -newkey rsa:4096 -nodes -sha256 -keyout ~/registry/certs/domain.key \
-x509 -days 365 -out ~/registry/certs/domain.crt \
-subj "/C=KR/ST=Seoul/L=Seoul/O=Kosa/CN=hub.kosa.kr"
```

### 2.2 사용자 인증 설정

```bash
sudo apt install apache2-utils -y
mkdir -p ~/registry/auth
htpasswd -Bc ~/registry/auth/htpasswd admin
```

### 2.3 레지스트리 컨테이너 가동

```bash
docker run -d \
  --name registry \
  --restart=always \
  -v ~/registry/certs:/certs \
  -v ~/registry/auth:/auth \
  -e REGISTRY_HTTP_ADDR=0.0.0.0:443 \
  -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt \
  -e REGISTRY_HTTP_TLS_KEY=/certs/domain.key \
  -e REGISTRY_AUTH=htpasswd \
  -e REGISTRY_AUTH_HTPASSWD_REALM="Registry Realm" \
  -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd \
  -p 443:443 \
  registry:2
```

---

## 3. 컨테이너 네트워크 (MacVLAN)

### 3.1 MacVLAN 네트워크 생성

```bash
# eth0는 실제 호스트 인터페이스 명칭으로 변경 필요
docker network create -d macvlan \
  --subnet=172.16.31.0/24 \
  --gateway=172.16.31.1 \
  -o parent=eth0 \
  macvlan_net
```

---

## 4. 방화벽 정책 (UFW)

### 4.1 기본 정책 및 허용 규칙

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing

# 서비스 포트 허용
sudo ufw allow 2222/tcp  # SSH (하드닝 포트)
sudo ufw allow 80/tcp    # HTTP
sudo ufw allow 443/tcp   # HTTPS/Registry

# ICMP (Ping) 차단 설정
sudo vi /etc/ufw/before.rules
```

```yaml
# /etc/ufw/before.rules 상단에 추가 (DROP icmp)
-A ufw-before-input -p icmp --icmp-type echo-request -j DROP
```

```bash
sudo ufw reload
```

# Nginx 성능 최적화(Tuning) 가이드

## 개요
- **목적:** 웹 서버, 리버스 프록시, 로드 밸런서 성능 극대화 및 응답 시간 단축.

## 핵심 튜닝 영역
1. **Worker Processes:** 시스템 CPU 코어 수와 일치화 (`worker_processes auto;`).
2. **Worker Connections:** 워커당 최대 연결 수 확장 (`worker_connections 1024;`).
3. **Keepalive:** 연결 재사용을 통한 핸드셰이크 오버헤드 축소 (`keepalive_timeout 65;`).
4. **Gzip 압축:** 데이터 전송량 감소 및 대역폭 효율화 (`gzip on;`).
5. **캐싱:** 빈번한 요청 데이터 메모리/디스크 저장 (`proxy_cache_path` 설정).

## 서비스 관리 명령어
- **부팅 시 자동 시작:** `sudo systemctl enable nginx`
- **서비스 제어:** `start`, `stop`, `restart` (완전 재시작).
- **설정 재로드:** `sudo systemctl reload nginx` (서비스 중단 없는 설정 반영).
- **상태 조회:** `sudo systemctl status nginx`

## 설정 검증
- **무결성 확인:** 설정 반영 전 구문 오류 점검 필수.
  - 명령어: `sudo nginx -t`

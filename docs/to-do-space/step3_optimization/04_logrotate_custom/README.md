# Logrotate 사용자 정의(Customizing) 가이드

## 개요

- **목적:** 로그 파일 자동 순환(rotation), 압축, 삭제 관리. 디스크 풀(Full) 장애 방지.
- **작동 기전:** `cron.daily` 주기 실행. `/etc/logrotate.conf` 및 `/etc/logrotate.d/` 설정 참조.

## 주요 설정 옵션

- **주기 설정:** `daily`, `weekly`, `monthly` (순환 간격).
- **보관 개수:** `rotate [개수]` (유지 로그 파일 수).
- **압축 여부:** `compress` (gzip 압축 적용).
- **예외 처리:** `missingok` (파일 부재 시 무시), `notifempty` (빈 파일 순환 제외).
- **후처리:** `postrotate` (순환 후 서비스 재시작 등 스크립트 실행).

## 실무 적용 절차

1. **설정 생성:** `/etc/logrotate.d/[앱이름]` 파일 작성.
2. **디버깅:** `sudo logrotate -d [파일경로]` (실제 적용 없이 테스트 수행).
3. **강제 실행:** `sudo logrotate -f [파일경로]` (테스트 또는 즉시 순환 필요 시).

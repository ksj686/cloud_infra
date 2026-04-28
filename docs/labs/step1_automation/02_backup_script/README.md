# 자동 백업 및 순환(Rotation)

**목표:** `tar` 및 `find`를 사용한 백업 관리 자동화

## `tar` 이용 백업

- `tar` 명령 기반 압축 아카이브 파일 생성
- 실행 예시: `tar -czf backup_$(date +%Y%m%d).tar.gz /path/to/source_dir`
  - `-c`: 아카이브 생성
  - `-z`: gzip 압축
  - `-f`: 파일명 지정

## `find` 이용 백업 순환 관리

- 디스크 공간 확보를 위한 오래된 백업 파일 자동 삭제
- 실행 예시: `find /path/to/backups/ -type f -name "*.tar.gz" -mtime +7 -delete`
  - `-type f`: 파일 검색
  - `-name "*.tar.gz"`: 특정 백업 파일 매칭
  - `-mtime +7`: 수정된 지 7일 이상 된 파일 대상
  - `-delete`: 매칭된 파일 삭제

## 자동화 설정

- `cron` 활용 백업 예약 수행
- Crontab 설정 예시: `0 2 * * * /path/to/backup.sh` (매일 오전 2시 수행)

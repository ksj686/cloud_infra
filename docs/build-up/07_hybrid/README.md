# [Phase 7] Hybrid Cloud: 클라우드 연동 및 서비스 가속

AWS 클라우드 자원을 활용한 글로벌 콘텐츠 전송 및 보안 경계 확장 절차 정리

---

## 1. 정적 자산 가속화 및 오프로딩 (CloudFront)

웹 서버의 부하를 줄이고 전 세계 사용자에게 빠른 응답성을 제공하는 전략

- **CloudFront 배포 최적화:** 엣지 로케이션 캐싱을 통한 Latency 저감
- **실시간 데이터 압축:** Gzip/Brotli 적용을 통한 전송 효율성 극대화

## 2. 보안 스토리지 연동 (S3 & OAC)

민감한 원본 데이터를 보호하고 인가된 경로를 통해서만 접근을 허용하는 체계

- **Origin Access Control (OAC) 도입:** S3 버킷의 직접적인 인터넷 노출 원천 차단
- **버킷 정책 강화:** 최소 권한 원칙에 기반한 정밀한 접근 제어 목록(ACL) 관리

## 3. 하이브리드 자동화 관리 (Hybrid IaC)

온프레미스와 클라우드 리소스를 단일 파이프라인에서 관리하는 기법

- **Terraform AWS Provider 활용:** S3 버킷, CloudFront Distribution, ACM 인증서의 선언적 프로비저닝
- **하이브리드 가시성:** 클라우드 리소스 사용량 및 비용에 대한 통합 모니터링 연동

---

## 상세 구현 및 명세

- **상세 구현 지침서:** [IMPLEMENTATION.md](./IMPLEMENTATION.md)
- **실구축 명세서:** [AS_BUILT.md](./AS_BUILT.md)

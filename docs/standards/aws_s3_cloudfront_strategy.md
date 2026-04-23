# AWS S3 & CloudFront 가속 및 보안 전략 (Cloud Edge Strategy)

본 문서는 정적 자산의 글로벌 가속 및 보안 강화를 위해 AWS S3와 CloudFront를 연동하는 표준 아키텍처와 관리 원칙 정리

---

## 1. 핵심 아키텍처 개요 (Architecture)

```mermaid
graph LR
    User[User] -->|HTTPS| CF[AWS CloudFront]
    CF -->|Edge Cache| User
    CF -->|OAC| S3[AWS S3 Bucket]
    S3 -.->|Private| S3
    style S3 fill:#f96,stroke:#333
    style CF fill:#69f,stroke:#333
```

- **S3 (Storage):** 원본 데이터(정적 파일)의 안전한 보관소. 직접 외부 노출 차단.
- **CloudFront (CDN):** 전 세계 엣지 로케이션을 통한 콘텐츠 캐싱 및 가속 수행.
- **OAC (Origin Access Control):** S3 버킷 권한을 CloudFront 서비스로만 한정하여 우회 접속 원천 봉쇄.

---

## 2. 가속 및 최적화 전략 (Performance)

- **전역 가속 (Global Acceleration):** 엣지 로케이션 캐싱을 통한 물리적 거리 기반 응답 지연(Latency) 최소화.
- **캐시 정책(TTL) 최적화:**
  - 정적 자산(이미지, JS 등)은 긴 TTL 부여로 캐시 히트율(Hit Ratio) 극대화.
  - 업데이트 잦은 설정 파일은 `CloudFront Invalidation`을 통한 수동 갱신 수행.
- **전송 압축 (Gzip/Brotli):** 전송 시 실시간 압축 적용을 통한 데이터 전송량 절감 및 로딩 속도 향상.

---

## 3. 보안 가드레일 (Security Guardrails)

- **OAC 기반 버킷 보안 정책 (Bucket Policy):**
  ```json
  {
    "Version": "2012-10-17",
    "Statement": {
      "Sid": "AllowCloudFrontServicePrincipalReadOnly",
      "Effect": "Allow",
      "Principal": { "Service": "cloudfront.amazonaws.com" },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::your-bucket-name/*",
      "Condition": {
        "StringEquals": {
          "AWS:SourceArn": "arn:aws:cloudfront::123456789012:distribution/ED..."
        }
      }
    }
  }
  ```
- **전송 구간 암호화:** ACM(AWS Certificate Manager) 인증서 기반의 전 구간 HTTPS 통신 강제.
- **WAF 연동:** SQL 인젝션, XSS 공격 등 악성 트래픽 차단을 위한 Web Application Firewall 적용.

---

## 4. 코드형 인프라 구현 (Terraform)

```hcl
# S3 버킷 생성
resource "aws_s3_bucket" "static_assets" {
  bucket = "kosa-infra-assets"
}

# CloudFront 배포 및 OAC 연결
resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.static_assets.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.default.id
    origin_id                = "S3Origin"
  }
  enabled             = true
  default_root_object = "index.html"
  # (이후 캐시 및 SSL 설정 생략)
}
```

---

## 5. 결론 및 제언

- S3/CDN 조합은 서버의 I/O 부하를 획기적으로 줄이는 **'인프라 오프로딩(Offloading)'**의 핵심 기술임.
- 온프레미스(Proxmox) 서비스와의 하이브리드 연동 시, 클라우드 자격 증명 관리를 위해 **`IAM Roles`** 또는 **`Vault`** 연동을 권장함.

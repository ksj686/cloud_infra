# Implementation Guide: Phase 7 Hybrid Cloud

본 문서는 Phase 7 AWS 하이브리드 연동 및 데이터 가속 구성을 위한 상세 명령어 및 설정 파일 명세 정리

---

## 1. AWS 자원 프로비저닝 (Terraform)

### 1.1 S3 버킷 및 CloudFront OAC 설정

```hcl
# S3 버킷 생성
resource "aws_s3_bucket" "infra_assets" {
  bucket = "kosa-infra-static-assets"
}

# CloudFront OAC 설정 (Origin Access Control)
resource "aws_cloudfront_origin_access_control" "infra_oac" {
  name                              = "infra-oac"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# CloudFront Distribution 생성
resource "aws_cloudfront_distribution" "infra_cdn" {
  origin {
    domain_name              = aws_s3_bucket.infra_assets.bucket_regional_domain_name
    origin_id                = "S3Origin"
    origin_access_control_id = aws_cloudfront_origin_access_control.infra_oac.id
  }
  enabled             = true
  default_root_object = "index.html"
  # (이후 캐시 및 뷰어 프로토콜 설정 생략)
}
```

---

## 2. 보안 정책 강화 (AWS CLI)

### 2.1 S3 버킷 정책 업데이트 (OAC 전용 허용)

```bash
# bucket-policy.json 작성
cat <<EOF > bucket-policy.json
{
    "Version": "2012-10-17",
    "Statement": {
        "Sid": "AllowCloudFrontServicePrincipalReadOnly",
        "Effect": "Allow",
        "Principal": { "Service": "cloudfront.amazonaws.com" },
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::kosa-infra-static-assets/*",
        "Condition": {
            "StringEquals": { "AWS:SourceArn": "arn:aws:cloudfront::123456789012:distribution/ED123456789" }
        }
    }
}
EOF

# 정책 적용
aws s3api put-bucket-policy --bucket kosa-infra-static-assets --policy file://bucket-policy.json
```

---

## 3. 정적 자산 배포 및 동기화

### 3.1 S3 정적 파일 업로드

```bash
# 로컬 빌드 결과물을 S3로 동기화
aws s3 sync ./dist/ s3://kosa-infra-static-assets/ --delete
```

### 3.2 CloudFront 캐시 무효화 (Invalidation)

```bash
# 수동 갱신 시 수행
aws cloudfront create-invalidation --distribution-id ED123456789 --paths "/*"
```

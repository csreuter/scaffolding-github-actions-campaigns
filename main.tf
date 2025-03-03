# main.tf

resource "aws_s3_bucket" "campaigns-resource_ckaMshbmm94dxMYO" {
  bucket = "campaigns-resource-test-bucket-demo1"
}

resource "aws_s3_bucket_public_access_block" "campaigns-resource_ckaMshbmm94dxMYO" {
  bucket                  = aws_s3_bucket.campaigns-resource_ckaMshbmm94dxMYO.id
  block_public_acls       = false
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "campaigns-resource_ckaMshbmm94dxMYO" {
  bucket = aws_s3_bucket.campaigns-resource_ckaMshbmm94dxMYO.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_versioning" "campaigns-resource_ckaMshbmm94dxMYO" {
  bucket = aws_s3_bucket.campaigns-resource_ckaMshbmm94dxMYO.id

  versioning_configuration {
    status = "Disabled"
  }
}

# KMS Key for RDS Encryption
resource "aws_kms_key" "kmskey_6rqH9awtV732LCTF" {
  description             = "KMS key for encrypting an RDS instance"
  key_usage               = "ENCRYPT_DECRYPT"
  is_enabled              = true
  deletion_window_in_days = 30
}

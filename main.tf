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
resource "aws_kms_key" "example-rds_457SwZ4yAAv47zpt_kmskey" {
  description             = "KMS key for encrypting example-rds RDS instance"
  key_usage               = "ENCRYPT_DECRYPT"
  is_enabled              = true
  deletion_window_in_days = 30
}

# RDS Instance with Best Practices
resource "aws_db_instance" "example-rds_457SwZ4yAAv47zpt" {
  identifier                   = "example-rds"
  engine                       = "postgres"
  engine_version               = "14.1"
  instance_class               = "db.m1.small"
  allocated_storage            = 20
  max_allocated_storage        = 100
  db_name                      = "app_database"
  username                     = "db_user"
  password                     = "my-password"
  backup_retention_period      = 7
  storage_encrypted            = false
  kms_key_id                   = aws_kms_key.example-rds_457SwZ4yAAv47zpt_kmskey.arn
  multi_az                     = true
  deletion_protection          = true
  performance_insights_enabled = true
  skip_final_snapshot          = false
}

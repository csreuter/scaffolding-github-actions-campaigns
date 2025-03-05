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

# RDS Instance with Best Practices
resource "aws_db_instance" "example-rds_TJXZTFi3qSy724Fv" {
  identifier                   = "example-rds"
  engine                       = "postgres"
  engine_version               = "17.2"
  instance_class               = "db.t3.micro"
  allocated_storage            = 20
  max_allocated_storage        = 100
  db_name                      = "app_database"
  username                     = "db_user"
  password                     = "password"
  backup_retention_period      = 7
  storage_encrypted            = false
  multi_az                     = true
  deletion_protection          = true
  performance_insights_enabled = true
  skip_final_snapshot          = true
}

# AWS Virtual Private Cloud (VPC)
resource "aws_vpc" "example-vpc_Ce28TLUr3w7XWNgi" {
  cidr_block                       = "10.0.0.0/16"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  instance_tenancy                 = "default"
  assign_generated_ipv6_cidr_block = true
  tags = {
    owner = "Chris"
  }
}

# AWS Security Group
resource "aws_security_group" "web-server-sg_gJMP4fnXzbWhixq5" {
  name   = "web-server-sg"
  vpc_id = aws_vpc.example-vpc_Ce28TLUr3w7XWNgi.id
  tags = {
    owner = "Chris"
  }

  ingress {
    protocol    = "tcp"
    from_port   = 5432
    to_port     = 5432
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    protocol    = "tcp"
    from_port   = 5432
    to_port     = 5432
    cidr_blocks = ["10.0.0.0/16"]
  }
}

# AWS Subnet
resource "aws_subnet" "public-subnet-1_d4E3eQNPyyfkPQiz" {
  vpc_id                  = aws_vpc.example-vpc_Ce28TLUr3w7XWNgi.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = us-west-2a"
  map_public_ip_on_launch = false
  tags = {
    owner = "Chris"
  }
}

# AWS Elastic Load Balancer (ELB)
resource "aws_elb" "example-elb_abbxUgDfSDdM4PXf" {
  name            = "example-elb"
  internal        = false
  security_groups = [aws_security_group.web-server-sg_gJMP4fnXzbWhixq5.id]
  subnets         = [aws_subnet.public-subnet-1_d4E3eQNPyyfkPQiz.id]
  tags = {
    owner = "Chris"
  }

  listener {
    instance_port     = 80
    instance_protocol = "HTTP"
    lb_port           = 80
    lb_protocol       = "HTTP"
  }

  health_check {
    target              = "HTTP:80/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

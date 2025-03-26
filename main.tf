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
  tags = {
    backup = "true"
  }
}

resource "aws_db_instance" "key-application-dev" {
  identifier                   = "key-application-dev"
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

resource "aws_db_instance" "key-application-prod" {
  identifier                   = "key-application-prod"
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
  tags = {
    backup = "true"
  }
}

# AWS Virtual Private Cloud (VPC)
resource "aws_vpc" "example-vpc_GqdekqYpVkAFP6QX" {
  cidr_block                       = "10.0.0.0/16"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  instance_tenancy                 = "default"
  assign_generated_ipv6_cidr_block = true
  tags = {
    owner = "Chris"
  }
}

# AWS Subnet
resource "aws_subnet" "public-subnet-1_7nZ8v33Nhz5TQ69k" {
  vpc_id                  = aws_vpc.example-vpc_GqdekqYpVkAFP6QX.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true
  tags = {
    owner = "Chris"
  }
}

# AWS Security Group
resource "aws_security_group" "web-server-sg_dJZqk837GhmTNZGA" {
  name   = "web-server-sg"
  vpc_id = aws_vpc.example-vpc_GqdekqYpVkAFP6QX.id
  tags = {
    owner = "Chris"
  }

  ingress {
    protocol    = "tcp"
    from_port   = 5432
    to_port     = 5432
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "tcp"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Internet Gateway
resource "aws_internet_gateway" "public-gateway_vEqghHimEJ47pvV8_igw" {
  vpc_id = aws_vpc.example-vpc_GqdekqYpVkAFP6QX.id
  tags = {
    Name  = "public-gateway-igw"
    Owner = "Chris"
  }
}

# Route Table for Internet Access
resource "aws_route_table" "public-gateway_vEqghHimEJ47pvV8_rt" {
  vpc_id = aws_vpc.example-vpc_GqdekqYpVkAFP6QX.id
  tags = {
    Name  = "public-gateway-route-table"
    Owner = "Chris"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.public-gateway_vEqghHimEJ47pvV8_igw.id
  }
}

# Route Table Association
resource "aws_route_table_association" "public-gateway_vEqghHimEJ47pvV8_rta" {
  subnet_id      = aws_subnet.public-subnet-1_7nZ8v33Nhz5TQ69k.id
  route_table_id = aws_route_table.public-gateway_vEqghHimEJ47pvV8_rt.id
}

# AWS Elastic Load Balancer (ELB)
resource "aws_elb" "example-elb_zVYxBfXfh7gEiERm" {
  name            = "example-elb"
  internal        = false
  security_groups = [aws_security_group.web-server-sg_dJZqk837GhmTNZGA.id]
  subnets         = [aws_subnet.public-subnet-1_7nZ8v33Nhz5TQ69k.id]
  tags = {
    Owner = "Chris"
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

resource "aws_iam_group" "my-iam-group_dzNUazB945E6fZSj" {
  name = "my-iam-group"
}

resource "aws_iam_group_membership" "my-iam-group_dzNUazB945E6fZSj_group_membership" {
  name  = "my-iam-group_membership"
  group = aws_iam_group.my-iam-group_dzNUazB945E6fZSj.name
  users = []
}

resource "aws_iam_group_policy_attachment" "my-iam-group_dzNUazB945E6fZSj_policy_attachment_0" {
  group      = aws_iam_group.my-iam-group_dzNUazB945E6fZSj.name
  policy_arn = resource.aws_iam_policy.overly-permissive-policy_0.arn
}

resource "aws_iam_policy" "overly-permissive-policy_0" {
  name        = "overly-permissive-policy"
  description = "Custom IAM policy for my-iam-group group."
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "rds:*"
        ]
        Effect = "Allow"
        Resource = ["*"]
      }
    ]
  })
}



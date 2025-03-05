// This resource stores answers for Resourcely's global context questions. It is safe to edit this block by hand. Edits
// are generally safe, except for renaming or removing the block. See documentation for more details.
// https://docs.resourcely.io/concepts/other-features-and-settings/global-context-and-values#resource-level-answers
resource "terraform_data" "resourcely_context_answers" {
  input = {
    "version" : 1,
    "data" : [
      {
        "$applies_to" : [
          "resource.aws_kms_key.example-rds_457SwZ4yAAv47zpt_kmskey",
          "resource.aws_db_instance.example-rds_457SwZ4yAAv47zpt",
          "resource.aws_kms_key.kmskey_HyK3hBPRDjhLpTT9",
          "resource.aws_db_instance.example-rds_mq66xDMcEGMGZMbZ",
          "resource.aws_kms_key.kmskey_YQxK9CH3weQj5E7Y",
          "resource.aws_db_instance.example-rds_YDW8SL8PdmHMCwDu",
          "resource.aws_kms_key.kmskey_6rqH9awtV732LCTF",
          "resource.aws_db_instance.example-rds_kB9bGDNyJmy9WPbv",
          "resource.aws_vpc.example-vpc_Ce28TLUr3w7XWNgi",
          "resource.aws_security_group.web-server-sg_gJMP4fnXzbWhixq5",
          "resource.aws_subnet.public-subnet-1_d4E3eQNPyyfkPQiz",
          "resource.aws_elb.example-elb_abbxUgDfSDdM4PXf"
        ],
        "gdpr_apply" : "Yes"
      },
      {
        "$applies_to" : "resource.aws_db_instance.example-rds_TJXZTFi3qSy724Fv",
        "gdpr_apply" : "No"
      }
    ]
  }
}
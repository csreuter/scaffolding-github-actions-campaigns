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
          "resource.aws_db_instance.example-rds_mq66xDMcEGMGZMbZ"
        ],
        "gdpr_apply" : "Yes"
      }
    ]
  }
}
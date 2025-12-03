terraform {
  cloud {

    organization = "Ank_DevOps"

    workspaces {
      name = "snowflake_devops"
    }
  }
  required_providers {
    snowflake = {
      source = "snowflakedb/snowflake"
    }
  }

  /* backend "s3" {
    bucket         = "<your-bucket-name>"
    key            = "terraform-staging.tfstate"
    region         = "<bucket-region>"
    # Optional DynamoDB for state locking. See https://developer.hashicorp.com/terraform/language/settings/backends/s3 for details.
    # dynamodb_table = "terraform-state-lock-table"
    encrypt        = true
    role_arn       = "arn:aws:iam::<your-aws-account-no>:role/<terraform-s3-backend-access-role>"
  } */
}

provider "snowflake" {
  organization_name        = "hgaducs"
  account_name             = "BYB05099"
  user                     = "SVC_DEVOPS"
  role                     = "ACCOUNTADMIN"
  authenticator            = "SNOWFLAKE_JWT"
  private_key              = var.snowflake_private_key
  preview_features_enabled = ["snowflake_table_resource", ]
}

module "snowflake_resources" {
  source              = "../modules/snowflake_resources"
  time_travel_in_days = 1
  database            = var.database
  env_name            = var.env_name
}
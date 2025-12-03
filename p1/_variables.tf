variable "database" {
  type    = string
  default = "TERRAFORM_DEMO_p1"
}

variable "env_name" {
  type    = string
  default = "p1"
}

variable "snowflake_private_key" {
  type        = string
  description = "Private key used to access Snowflake"
  sensitive   = true

}
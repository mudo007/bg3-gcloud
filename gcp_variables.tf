/*
 * Variaveis Terraform para GCP.
 */

variable "PROJID" {
  description = "GCP project ID."
  type        = string
}

variable "REGION" {
  description = "Standard for Ashburn, Virginia"
  default     = "us-east4-a"
}
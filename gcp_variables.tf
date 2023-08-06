/*
 * Variaveis Terraform para GCP.
 */

variable "PROJID" {
  description = "GCP project ID."
  type        = string
}

variable "ZONE" {
  description = "Zone within a region"
  type        = string
}

variable "GPU" {
  description = "GPU type"
  type        = string
}
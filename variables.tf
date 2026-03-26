variable "name_prefix" {
  description = "Prefix to be used on all the resources as identifier"
  type        = string
}

variable "alb_arn" {
  description = "The ARN of the Application Load Balancer to associate with the WAF Web ACL"
  type        = string
}

variable "scope" {
  description = "Scope for the Web ACL. This module is intended for REGIONAL use with ALB association."
  type        = string
  default     = "REGIONAL"
  validation {
    condition     = contains(["REGIONAL", "CLOUDFRONT"], var.scope)
    error_message = "VALIDATION: Scope must be either REGIONAL or CLOUDFRONT."
  }
}

variable "common_tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

provider "aws" {
  region = "us-east-1"
}

module "waf_acl_basic" {
  source = "../../"

  name_prefix = "example-basic"
  alb_arn     = "arn:aws:elasticloadbalancing:us-east-1:123456789012:loadbalancer/app/dummy-alb/50dc6c495c0c9188"

  common_tags = {
    Environment = "dev"
    Project     = "waf-example"
  }
}

output "web_acl_arn" {
  description = "The ARN of the WAFv2 Web ACL"
  value       = module.waf_acl_basic.web_acl_arn
}

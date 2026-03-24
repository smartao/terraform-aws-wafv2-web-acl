provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
}

variables {
  name_prefix = "test-simple"
  alb_arn     = "arn:aws:elasticloadbalancing:us-east-1:123456789012:loadbalancer/app/test-alb/50dc6c495c0c9188"
}

run "valid_web_acl" {
  command = plan

  assert {
    condition     = aws_wafv2_web_acl.main.name == "test-simple-web-acl"
    error_message = "Web ACL name does not match the expected prefix"
  }

  assert {
    condition     = aws_wafv2_web_acl.main.scope == "REGIONAL"
    error_message = "Web ACL scope should be REGIONAL by default"
  }

  assert {
    condition     = length(aws_wafv2_web_acl.main.rule) == 3
    error_message = "Web ACL should have 3 rules (Common, SQLi, and KnownBadInputs)"
  }
}

run "valid_association" {
  command = plan

  assert {
    condition     = aws_wafv2_web_acl_association.alb_association.resource_arn == "arn:aws:elasticloadbalancing:us-east-1:123456789012:loadbalancer/app/test-alb/50dc6c495c0c9188"
    error_message = "Web ACL association should match the provided ALB ARN"
  }
}

# AWS WAFv2 Web ACL Terraform Module

Terraform module which creates a WAFv2 Web ACL on AWS and associates it with an Application Load Balancer (ALB).

## Features

- Creates an AWS WAFv2 Web ACL.
- Includes pre-configured AWS Managed Rules:
  - **Common Rule Set**: Contains rules that are generally applicable to web applications.
  - **SQL Injection Rule Set**: Contains rules to block request patterns associated with SQL injection attacks.
  - **Known Bad Inputs Rule Set**: Contains rules to block request patterns that are known to be invalid and are associated with exploitation or discovery of vulnerabilities.
- Automatic association with an ALB.
- CloudWatch metrics and sampled requests visibility.

## Usage

```hcl
module "waf_acl" {
  source  = "smartao/wafv2-web-acl/aws"
  version = "~> 1.0"

  name_prefix = "my-app"
  alb_arn     = "arn:aws:elasticloadbalancing:us-east-1:123456789012:loadbalancer/app/my-load-balancer/50dc6c495c0c9188"

  common_tags = {
    Environment = "production"
    Project     = "my-project"
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_wafv2_web_acl.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl) | resource |
| [aws_wafv2_web_acl_association.alb_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_arn"></a> [alb\_arn](#input\_alb\_arn) | The ARN of the Application Load Balancer to associate with the WAF Web ACL | `string` | n/a | yes |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | A mapping of tags to assign to the resource | `map(string)` | `{}` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix to be used on all the resources as identifier | `string` | n/a | yes |
| <a name="input_scope"></a> [scope](#input\_scope) | Specifies whether this is for an AWS CloudFront distribution or for a regional application | `string` | `"REGIONAL"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_web_acl_arn"></a> [web\_acl\_arn](#output\_web\_acl\_arn) | The ARN of the WAFv2 Web ACL |
| <a name="output_web_acl_capacity"></a> [web\_acl\_capacity](#output\_web\_acl\_capacity) | The Web ACL capacity units (WCUs) currently being used by this web ACL |
| <a name="output_web_acl_id"></a> [web\_acl\_id](#output\_web\_acl\_id) | The ID of the WAFv2 Web ACL |
<!-- END_TF_DOCS -->
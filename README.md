![license](https://img.shields.io/badge/License-MIT-orange?style=flat-square)

# 📦 terraform-aws-wafv2-web-acl

Terraform module to provision an AWS WAFv2 Web ACL and associate it with an Application Load Balancer (ALB).

The module creates a Web ACL with a set of pre-configured AWS Managed Rules to protect your application from common web exploits. It handles the association with an existing ALB and provides visibility through CloudWatch metrics.

## ⚙️ What This Module Does

- Creates an AWS WAFv2 Web ACL.
- Includes pre-configured AWS Managed Rules:
  - **Common Rule Set**: Protection against common web exploits.
  - **SQL Injection Rule Set**: Guards against SQLi attack patterns.
  - **Known Bad Inputs Rule Set**: Blocks requests known to be invalid or associated with vulnerability discovery.
- Automatically associates the Web ACL with a specified ALB.
- Enables CloudWatch metrics and sampled requests for visibility.
- Supports both `REGIONAL` and `CLOUDFRONT` scopes (defaulted to `REGIONAL`).

## ⚠️ Important Notes

- This module does not create the ALB; it requires an existing `alb_arn`.
- Default action for requests that don't match any rules is set to `ALLOW`.
- Web ACL capacity units (WCUs) are calculated based on the included rule sets.
- Ensure the `scope` variable matches the resource type being protected.

## 📑 Prerequisites

Before using this module, you should already have:

- An existing Application Load Balancer (ALB) if using `REGIONAL` scope.
- AWS credentials configured for Terraform.
- Appropriate permissions to create WAFv2 resources.

## 🚀 Quick Start

```hcl
provider "aws" {
  region = "us-east-1"
}

module "waf_acl" {
  source = "sergeimatos/wafv2-web-acl/aws"

  name_prefix = "my-app"
  alb_arn     = "arn:aws:elasticloadbalancing:us-east-1:123456789012:loadbalancer/app/my-load-balancer/50dc6c495c0c9188"

  common_tags = {
    Environment = "production"
    Project     = "security-infrastructure"
  }
}
```

Run:

```bash
terraform init
terraform plan
terraform apply
```

## 🔐 Security Guidance

- **Managed Rules**: Regularly review the performance and matches of the AWS Managed Rules.
- **Logging**: For full request visibility, consider enabling WAFv2 Logging to S3 or CloudWatch Logs (not currently implemented in this module).
- **Default Action**: In highly sensitive environments, you might want to switch to a `block` default action and explicitly allow traffic, though this module currently defaults to `allow`.

## 📁 Typical Use Case

```text
Internet
    |
    v
AWS WAFv2 (Web ACL)
    | (Filters malicious traffic)
    v
Application Load Balancer (ALB)
    |
    v
Private Infrastructure
  |- EC2 Instances
  |- ECS Services
  `- Lambda Functions
```

## 🧩 Example

- [Simple example](examples/simple)
- The `examples/simple` directory uses a local relative source for development and testing of this repository.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.37.0 |

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
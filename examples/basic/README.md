# Basic WAFv2 Web ACL Association Example

This example demonstrates how to create an AWS WAFv2 Web ACL and associate it with an Application Load Balancer (ALB) using the standard AWS Managed Rules.

## Components

- **WAFv2 Web ACL**: Includes Common Rule Set, SQL Injection, and Known Bad Inputs rules.
- **ALB Association**: Attaches the Web ACL to a regional Application Load Balancer.

## Usage

1. Configure your AWS credentials.
2. Update the `alb_arn` in `main.tf` with your target ALB ARN.
3. Run Terraform commands:

```bash
terraform init
terraform plan
terraform apply
```

## Example Code

```hcl
module "waf_acl_basic" {
  source = "../../"

  name_prefix = "example-basic"
  alb_arn     = "arn:aws:elasticloadbalancing:us-east-1:123456789012:loadbalancer/app/dummy-alb/50dc6c495c0c9188"

  common_tags = {
    Environment = "dev"
    Project     = "waf-example"
  }
}
```

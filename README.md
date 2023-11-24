# terraform-aws-iam-role
# AWS IAM Role Terraform Configuration

## Table of Contents

- [Introduction](#introduction)
- [Usage](#usage)
- [Module Inputs](#module-inputs)
- [Module Outputs](#module-outputs)
- [Examples](#examples)
- [Author](#author)
- [License](#license)

## Introduction

This Terraform configuration sets up an AWS Identity and Access Management (IAM) role with associated policies, specifically designed for EC2 instances. The role allows EC2 instances to assume it and has a policy granting permissions related to AWS Systems Manager (SSM).

## Usage

To get started, make sure you have configured your AWS provider. You can use the following code as a starting point:

```hcl

module "iam-role" {
  source             = "git::https://github.com/cypik/terraform-aws-iam-role.git?ref=v1.0.0"
  name               = "iam"
  environment        = "test"
  assume_role_policy = data.aws_iam_policy_document.default.json
  policy_enabled     = true
  policy             = data.aws_iam_policy_document.iam-policy.json
}
```
Make sure to configure the variables according to your requirements.

## Module Inputs
- name (string): The name of the IAM role.
- environment (string): The environment in which the IAM role is being created.
- assume_role_policy (object): The IAM policy document defining who can assume the role.
- policy_enabled (bool): Flag indicating whether the IAM policy should be enabled.
- policy (object): The IAM policy document defining the permissions granted.

## Module Outputs
- iam_role_arn (string): The ARN of the created IAM role.

## Examples
For detailed examples on how to use this module, please refer to the [Examples](https://github.com/cypik/terraform-aws-iam-role/tree/master/example) directory within this repository.

## Author
Your Name Replace '[License Name]' and '[Your Name]' with the appropriate license and your information. Feel free to expand this README with additional details or usage instructions as needed for your specific use case.

## License
This project is licensed under the MIT License - see the [LICENSE](https://github.com/cypik/terraform-aws-iam-role/blob/master/LICENSE) file for details.

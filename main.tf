##-----------------------------------------------------------------------------
## Labels module callled that will be used for naming and tags.
##-----------------------------------------------------------------------------
module "labels" {
  source      = "cypik/labels/aws"
  version     = "1.0.2"
  enabled     = var.enabled
  name        = var.name
  repository  = var.repository
  environment = var.environment
  managedby   = var.managedby
  label_order = var.label_order
}

##-----------------------------------------------------------------------------
## Below resource will deploy IAM role in AWS environment.
##----------------------------------------------------------------------------
resource "aws_iam_role" "default" {
  count                 = var.enabled ? 1 : 0
  name                  = module.labels.id
  assume_role_policy    = var.assume_role_policy
  force_detach_policies = var.force_detach_policies
  path                  = var.path
  description           = var.description
  max_session_duration  = var.max_session_duration
  permissions_boundary  = var.permissions_boundary
  tags                  = module.labels.tags
}

#-----------------------------------------------------------------------------
# Below resource will deploy IAM policy and attach it to above created IAM role.
#-----------------------------------------------------------------------------
resource "aws_iam_role_policy" "default" {
  count  = var.enabled && var.policy_enabled && var.policy_arn == "" ? 1 : 0
  name   = format("%s-policy", module.labels.id)
  role   = join("", aws_iam_role.default[*].id)
  policy = var.policy
}

##-----------------------------------------------------------------------------
## Below resource will attach IAM policy to above created IAM role.
##-----------------------------------------------------------------------------
resource "aws_iam_role_policy_attachment" "default" {
  count      = var.enabled && var.policy_enabled && var.policy_arn != "" ? 1 : 0
  role       = join("", aws_iam_role.default[*].id)
  policy_arn = var.policy_arn
}

##-----------------------------------------------------------------------------
## Below resource will attach managed policies to the IAM role using aws_iam_role_policy_attachment.
##-----------------------------------------------------------------------------
resource "aws_iam_role_policy_attachment" "managed_policies" {
  count      = var.enabled && var.managed_policy_arns != 0 ? length(var.managed_policy_arns) : 0
  role       = join("", aws_iam_role.default[*].id)
  policy_arn = element(var.managed_policy_arns, count.index)
}

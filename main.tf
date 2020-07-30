provider "aws" {}

data "aws_caller_identity" "current" {}

resource "aws_iam_role" "dev_project_role" {
    name = format("prj-%s-dev", var.project_name)
    assume_role_policy = templatefile("${path.module}/policies/assume_dev_role_default_policy.json", { account_id = data.aws_caller_identity.current.account_id })

    tags = {
        access-project = var.project_name
        access-team = var.dev_team_name
    }
}

resource "aws_iam_group" "dev" {
    name = format("prj-%s-dev", var.project_name)
}

data "aws_iam_policy" "abac" {
    arn = format("arn:aws:iam::%s:policy/ABAC_Limited_Services", data.aws_caller_identity.current.account_id)
}

resource "aws_iam_policy" "assume_role" {
    name = format("prj-%s-assume-dev-role", var.project_name)
    policy = templatefile("${path.module}/policies/assume_dev_role_policy.json", { role = aws_iam_role.dev_project_role.arn })
}

resource "aws_iam_group_policy_attachment" "dev_assume_role" {
    group = aws_iam_group.dev.name
    policy_arn = aws_iam_policy.assume_role.arn
}

resource "aws_iam_role_policy_attachment" "abac" {
    role = aws_iam_role.dev_project_role.name
    policy_arn = data.aws_iam_policy.abac.arn
}

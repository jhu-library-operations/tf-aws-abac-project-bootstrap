output "group_name" {
  value = aws_iam_group.dev.name
}

output "role_arn" {
  value = aws_iam_role.dev_project_role.arn
}

output "role_name" {
  value = aws_iam_role.dev_project_role.name
}
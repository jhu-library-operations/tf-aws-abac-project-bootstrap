# MSEL Project Bootstrap Terraform 

## Description
This project bootstraps an AWS project with the ABAC style of permissions.  It creates the follwowing:

- An IAM Group. This  group is assigned one policy, the ability to assume a specific role
- An IAM Role. This role is assumed by the IAM Group that is created. It is assigned one policy that is a data source. This policy must exist beforehand. The assume role is follows the format of "aws:arn:iam::${ACCOUNT_ID}:policy/ABAC_Limited_Services. I plan to break this out as a variable

## TODO
1. Break out the policy to be attached to the role as a variable so it can be dynamically added
2. Convert this to a Terraform module.

## How to Use
1. Checkout the repository
2. Modify terraform.tfvars
3. The Terraform dance of plan and apply


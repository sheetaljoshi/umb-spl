# SPL Exercise
This is a WIP provisioning project space. This project aims to provision load balanced web server hosting a static content on AWS. Autoscale if system capacity exceeds. On successful provision you should be able to use app_url printed at the end of the provision to login to web UI. 

The project is in it's very simplistic form. DNS and SSL support added, but not completely tested. Custom networking support will be added soon. 

Set aws_credentials_path variable if you would like to override default location ~/.aws/credentials. 

Tested against Terraform v0.14.3. Please submit issues for any problems.

## Usage

To run this project, execute

$ cd terraform
$ terraform init
$ terraform plan
$ terraform apply

## Defaults
Region defaults to us-east-1. Defaults all network (vpc, subnets).

## Inputs
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| insance\_count | Number of instances to create and attach to ELB | `number` | `2` | no |
| region | Region | `string` | `us-east-1` | no |
| aws\_credentials\_path | Credentials Path | `string` | `~/.aws/credentials` | no |

## Outputs
| Name | Description |
|------|-------------|
| app\_url | Application URL |

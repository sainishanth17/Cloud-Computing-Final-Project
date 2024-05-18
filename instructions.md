# Final Project

This final project involves setting up Social Something as a fully scalable web application using all of the following:

* Packer ✔️
* Terraform
* Auto Scaling Group
* RDS ✔️
* ALB
* VPC custom ✔️
* cloud watch ✔️
* s3 ✔️
* route 53
* 3 az ✔️
* 3 subnets for each thing ✔️

Kind of like week 4, but way more difficult: http://acit-3640-fall-2021.s3-website-us-west-1.amazonaws.com/week_4/

## Packer ✔️ 

* Use packer to setup the ami for the social something app. 
* Commit your packer code into git and push to github. Remember to add the correct gitignore.
* Remember that you'll need the cloud watch agent enabled to send logs to cloud watch

Code: https://github.com/sam-meech-ward-bcit/social_something_full

## Terraform

* Use terraform to setup every single piece of infrastructure. You shouldn't have to open the aws web terminal at all to complete this project.
* Organize your code into logical modules. There should be at least 3 modules but probably closer to 5 or 6 if done correctly.
* Use git to commit your code incrementally. I should see probably at least 5 separate and descriptive commits, but I would prefer to see more.
* Push the code to github. Remember to add the correct gitignore.

## VPC ✔️

Create a custom vpc for all of the infrastructure. You will include 9 subnets:

* 3 public subnets for the load balancer 
* 3 private subnets for the application instances
* 3 private subnets for the database instance

## RDS

Exactly the same as week 5 but with terraform and on a custom VPC

http://acit-3640-fall-2021.s3-website-us-west-1.amazonaws.com/week_5/

## S3 ✔️

Create an s3 bucket to store images for the app.

## IAM ✔️

The application instances need to be able to write to cloudwatch and access an s3 bucket, so make an IAM role with policies for that.

## Auto Scaling Group

Use an auto scaling group to deploy the application instances using the AMI. This means you'll also need a launch template with a cloud-config file to update the environment variables.

MYSQL_HOST='' 
MYSQL_USER='' 
MYSQL_PASSWORD='' 
MYSQL_DATABASE=''


## Load Balancer

Create an application load balancer to distribute traffic to all of the instances in the auto scaling group

## Route 53

* Create a subdomain that points to the load balancer.
* Create a certificate for the sub domain to enable https
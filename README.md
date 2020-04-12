# EC2-Scheduler-Terraform
<strong>About:</strong> Dynamic start/stop of AWS EC2 Instances based on cron expression. Uses AWS Lambda with Python 3.7 

<strong>Problem:</strong> EC2s are charged at an hourly rate and are often unused during off-hours. This causes an inflated operation cost and is often overlooked.

<strong>Solution:</strong> Stand up AWS Lambda with Cloudwatch cron triggers to execute start/stop commands given an existing EC2 instance ID.


### IAM Permissions
```
ec2:StartInstances
ec2:StopInstances
```





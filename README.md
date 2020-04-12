# EC2-Scheduler-Terraform

<strong>Author:</strong> Gar Lee

<strong>Problem:</strong> EC2s are charged at an hourly rate and are often unused during off-hours. This causes an inflated operation cost and is often overlooked.

<strong>Solution:</strong> Stand up AWS Lambda with Cloudwatch cron triggers to execute start/stop commands given an existing EC2 instance ID.

<strong>Performance:</strong>
> Buildtime and runtime on Python 3.7

> Deployed code bundle size is < 1kb

> Highly reusable across all planes

### IAM Permissions
```
ec2:StartInstances
ec2:StopInstances
```

### Usage
#### 1. AWS Credentials
```
  $ touch env.list
  $ cat env.list
  > AWS_REGION=YOUR_REGION
    AWS_ACCESS_KEY_ID=YOUR_ACCESS_KEY_ID
    AWS_SECRET_ACCESS_KEY=YOUR_SECRET_ACCESS_KEY
```

#### 2. Build/Package/Deploy using Docker 
```
  sh docker-deploy.sh <lambda-assume-role-arn> <ec2-instance-id>
```


#### Notes
By default, the start time for EC2 is 8AM PDT and stop time is at 10PM PDT. Parameterization feature will be included soon!



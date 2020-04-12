docker build -t ec2scheduler:v1 .
docker run --env AWS_LAMBDA_ASSUME_ROLE_ARN=$1 --env AWS_EC2_INSTANCE_ID=$2 --env-file env.list -t ec2scheduler:v1
docker rm -v $(docker ps -a -q -f status=exited)

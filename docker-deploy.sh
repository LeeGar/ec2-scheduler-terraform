docker build -t ec2scheduler:v1 .
docker run --env AWS_EC2_INSTANCE_ID=$1 --env-file env.list -t ec2scheduler:v1
docker rm -v $(docker ps -a -q -f status=exited)

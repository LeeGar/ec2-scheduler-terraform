# Clean
rm -rf ./build/*
mkdir -p ./build

# App
cp ./src/app.py ./build

# Dependencies
cp ./requirements.txt ./build

# Build and package
cd "./build"
pip3 install --target ./package -r requirements.txt
cd package
zip -r9 ${OLDPWD}/lambda.zip .
cd $OLDPWD

zip -g -r lambda.zip .

echo "Successfully created lambda zip"

# Deploy to AWS
cd ../lambda
terraform init
terraform apply \
    -var aws_lambda_assume_role_arn=$AWS_LAMBDA_ASSUME_ROLE_ARN \
    -var aws_ec2_instance_id=$AWS_EC2_NAT_INSTANCE_ID \
    -auto-approve

FROM python:3.7
MAINTAINER 'Gar Lee | gardarr@gmail.com'
RUN apt-get update
RUN apt-get install zip unzip -qy
ARG TERRAFORM_VERSION=0.12.20
RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
RUN unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
RUN chmod a+x terraform
RUN mv terraform /usr/local/bin
RUN rm -rf terraform_${TERRAFORM_VERSION}_linux_amd64.zip

COPY . .

CMD ["sh", "deploy.sh"]

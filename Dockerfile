FROM alpine:latest

COPY requirements.txt /tmp/requirements.txt

ARG TF_VERSION=0.12.29

RUN apk update \
	&& apk upgrade \
	&& apk add python3 py3-pip graphviz \
	curl \
	bash

RUN cd \
	#Install the AWSCLI
	&& pip3 install -r /tmp/requirements.txt \
	# Install Terraform Binary
	&& wget https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip \
	&& unzip terraform_${TF_VERSION}_linux_amd64 \
	&& mv terraform /usr/local/bin/ \
	# Install Open Policy Agent
    && wget https://openpolicyagent.org/downloads/latest/opa_linux_amd64 \
    && mv opa_linux_amd64 opa \
    && chmod 755 opa \
    && mv opa /usr/local/bin/ \
	# Cleanup zip files.
    && rm *.zip
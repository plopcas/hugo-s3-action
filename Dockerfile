FROM public.ecr.aws/aws-cli/aws-cli:latest

RUN yum update -y && \
    yum install -y curl jq

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

FROM public.ecr.aws/aws-cli/aws-cli:latest

RUN yum update -y && \
    yum install -y curl jq tar gzip

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

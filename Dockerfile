FROM pahud/awscli:with-bash

RUN apt update && apt install -y \
    curl jq

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
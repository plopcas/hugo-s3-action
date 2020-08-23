FROM pahud/awscli:with-bash

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
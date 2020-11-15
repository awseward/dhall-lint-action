FROM debian:stretch

RUN apt-get update \
 && apt-get install -y \
      bzip2 \
      git \
      wget

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

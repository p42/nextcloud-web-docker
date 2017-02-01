FROM project42/nextcloud-common:latest
MAINTAINER Jordan Clark jordan.clark@esu10.org

RUN apk add --no-cache nginx && \
mkdir /run/nginx

COPY container-files /

EXPOSE 80

ENTRYPOINT ["/init"]

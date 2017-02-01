FROM project42/nginx-s6-alpine:latest
MAINTAINER Jordan Clark jordan.clark@esu10.org

ENV NEXTCLOUD_VERSION 11.0.1

RUN apk add --no-cache curl gnupg && \
curl -fsSL -o nextcloud.tar.bz2 "https://download.nextcloud.com/server/releases/nextcloud-${NEXTCLOUD_VERSION}.tar.bz2" && \
curl -fsSL -o nextcloud.tar.bz2.asc "https://download.nextcloud.com/server/releases/nextcloud-${NEXTCLOUD_VERSION}.tar.bz2.asc" && \
export GNUPGHOME="$(mktemp -d)" && \
gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 28806A878AE423A28372792ED75899B9A724937A && \
gpg --batch --verify nextcloud.tar.bz2.asc nextcloud.tar.bz2 && \
rm -r "$GNUPGHOME" nextcloud.tar.bz2.asc && \
mkdir -p /var/www && \
tar -xjf nextcloud.tar.bz2 -C /tmp && \
mv /tmp/nextcloud /var/www/html && \
chown -R nginx /var/www/html && \
mkdir -p /usr/src/nextcloud && \
mv /var/www/html/apps /usr/src/nextcloud/ && \
mv /var/www/html/config /usr/src/nextcloud/ && \
rm nextcloud.tar.bz2

COPY container-files /

EXPOSE 80

ENTRYPOINT ["/init"]

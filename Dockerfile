FROM debian:bookworm-slim
MAINTAINER kenneth@floss.es
RUN apt-get update && \
    apt-get -y --no-install-recommends install \
        file curl unzip \
        libapache2-mod-php php-mysql php-gd php-curl && \
    rm -rf /var/lib/apt/lists/* && \
    a2enmod rewrite headers && \
    sed -i -e 's:${APACHE_LOG_DIR}/access.log:/dev/stdout:' -e 's:${APACHE_LOG_DIR}/error.log:/dev/stderr:' /etc/apache2/sites-available/*
COPY bootstrap.sh /
EXPOSE 80
ENTRYPOINT [ "/bootstrap.sh" ]

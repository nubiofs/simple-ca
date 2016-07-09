FROM alpine:3.4
RUN apk add --no-cache bash openssl lighttpd

ENV CERT_TLS=/ssl/www/localhost.pem
ENV CA_DIR=/ssl/ca
ENV CA_CN=my-ca
 
RUN cd /etc/lighttpd/\
 && mv lighttpd.conf lighttpd.conf.orig\
 && mv mod_cgi.conf mod_cgi.conf.orig

COPY lighttpd/ /etc/lighttpd/
COPY index.cgi /var/www/localhost/htdocs/
COPY start.sh /

RUN chmod +x /start.sh /var/www/localhost/htdocs/index.cgi\
 && mkdir -p /ssl\
 && chown lighttpd:lighttpd /run /ssl

USER lighttpd

CMD ["/start.sh"]
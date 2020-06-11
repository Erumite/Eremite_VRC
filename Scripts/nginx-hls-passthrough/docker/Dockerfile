FROM alpine

RUN apk update --no-cache && \
  apk add --no-cache git musl-dev gcc pcre-dev openssl-dev zlib-dev make && \
  git clone https://github.com/sergey-dryabzhinsky/nginx-rtmp-module.git && \
  wget http://nginx.org/download/nginx-1.19.0.tar.gz && \
  tar -xf nginx-1.19.0.tar.gz && cd nginx-1.19.0/ && \
  ./configure --with-http_ssl_module --add-module=../nginx-rtmp-module && \
  make -j 1 && make install ; cd .. ;\
  rm -rf /nginx-1.19.0 /nginx-1.19.0.tar.gz /nginx-rtmp-module/ ; \
  apk del --no-cache git musl-dev gcc make

VOLUME ["/var/log/nginxhls/"]
VOLUME ["/mnt/hls"]
ADD --chown=root:root ["./conf/nginx.conf", "/etc/nginx/nginx.conf"]

CMD ["/usr/local/nginx/sbin/nginx", "-c", "/etc/nginx/nginx.conf"]

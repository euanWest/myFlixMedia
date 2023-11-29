# Yoinked from: https://github.com/acobley/NginxVideo/blob/master/Dockerfile , 28/11/2023
FROM ubuntu:14.04
RUN apt-get -y -q update
RUN apt-get install -y git
RUN apt-get install -y gcc
RUN apt-get install -y make
RUN apt-get install -y libpcre3-dev
RUN apt-get install -y libssl-dev
RUN apt-get install -y wget
RUN mkdir -p mp4
RUN cd mp4
RUN wget https://storage.cloud.google.com/2420987-myflix-videos/AtomAgeVampire.mp4
RUN cd ..
RUN mkdir -p /home/mginx-rtmp-module
RUN git clone https://github.com/arut/nginx-rtmp-module /home/nginx-rtmp-module
RUN mkdir - p /home/nginx
RUN cd /home/nginx && wget http://nginx.org/download/nginx-1.4.3.tar.gz && tar zxpvf nginx-1.4.3.tar.gz
RUN cd /home/nginx/nginx-1.4.3 && ./configure --add-module=/home/nginx-rtmp-module/ --with-http_ssl_module --prefix=/usr/local/nginx-streaming/
RUN cd /home/nginx/nginx-1.4.3&& make && make install
RUN mkdir -p /var/www/html
RUN mkdir -p /var/nginx-streaming
RUN mkdir - /var/log/nginx
RUN cp /home/nginx-rtmp-module/stat.xsl /var/nginx-streaming/
ADD nginx/nginx.conf /usr/local/nginx-streaming/conf/nginx.conf
EXPOSE 80
EXPOSE 1935
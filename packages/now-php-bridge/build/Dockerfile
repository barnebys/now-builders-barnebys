FROM library/centos:6.8
ARG PHP_VERSION=73
ARG PHALCON_VERSION=3.4.3

RUN yum -y install wget git gcc make file
RUN yum install -y yum-utils epel-release which
RUN yum -y install -y http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
RUN yum-config-manager --enable remi-php$PHP_VERSION
RUN yum --enablerepo=remi-safe -y install \
	    php \
	    php-devel \
	    php-cli \
	    php-fpm \
	    php-opcache \
	    php-common \
	    php-mcrypt \
	    php-mysqli \
	    php-mbstring \
	    php-tokenizer

RUN yum -y install patchelf

#RUN wget https://github.com/phalcon/cphalcon/archive/v$PHALCON_VERSION.tar.gz && tar zxf v$PHALCON_VERSION.tar.gz
#RUN cd cphalcon-$PHALCON_VERSION/build && ./install

RUN mkdir -p /root/app/public

WORKDIR /root/app
COPY ./php-modules.conf /root/app/php-modules.conf
COPY ./php.ini /root/app/php.ini
COPY ./php-fpm.ini /root/app/php-fpm.ini
COPY ./test.php /root/app/test.php
COPY ./test.sh /root/app/test.sh
COPY ./php-modules.php /root/app/php-modules.php
RUN php php-modules.php

RUN patchelf --set-rpath '$ORIGIN' /usr/bin/php
RUN patchelf --set-rpath '$ORIGIN' /usr/sbin/php-fpm
RUN patchelf --set-rpath '$ORIGIN' /usr/lib64/php/modules/mysqli.so
RUN patchelf --set-rpath '$ORIGIN' /usr/lib64/php/modules/mysqlnd.so

CMD ["/bin/bash", "test.sh"]

#!/bin/sh
rm -rf ../native
mkdir -p ../native/modules
docker rmi now-php-docker-image --force
docker build . -t now-php-docker-image
docker run now-php-docker-image
docker run now-php-docker-image /bin/cat /usr/sbin/php-fpm > ../native/php-fpm
docker run now-php-docker-image /bin/cat /usr/bin/php > ../native/php
docker run now-php-docker-image /bin/cat /root/app/php.ini > ../native/php.ini
docker run now-php-docker-image /bin/cat /root/app/php-fpm.ini > ../native/php-fpm.ini
docker run now-php-docker-image /bin/cat /usr/lib64/libmcrypt.so.4 > ../native/modules/libmcrypt.so.4
docker run now-php-docker-image /bin/cat /usr/lib64/php/modules/opcache.so > ../native/modules/opcache.so
docker run now-php-docker-image /bin/cat /usr/lib64/libargon2.so.0 > ../native/libargon2.so.0

while read module; do
  docker run now-php-docker-image /bin/cat /usr/lib64/php/modules/$module.so > ../native/modules/$module.so
done <php-modules.conf

sed -i'.original' 's#/root/app/modules/#/root/app/native/modules/#g' ../native/php.ini

chmod +x ../native/php-fpm
chmod +x ../native/php

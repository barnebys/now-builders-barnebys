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
# GD Start
docker run now-php-docker-image /bin/cat /usr/lib64/libgd.so.3 > ../native/modules/libgd.so.3
docker run now-php-docker-image /bin/cat /usr/lib64/libX11.so.6 > ../native/modules/libX11.so.6
docker run now-php-docker-image /bin/cat /usr/lib64/libXpm.so.4 > ../native/modules/libXpm.so.4
docker run now-php-docker-image /bin/cat /usr/lib64/libpng12.so.0 > ../native/modules/libpng12.so.0
docker run now-php-docker-image /bin/cat /usr/lib64/libjpeg.so.62 > ../native/modules/libjpeg.so.62
docker run now-php-docker-image /bin/cat /usr/lib64/libfreetype.so.6 > ../native/modules/libfreetype.so.6
docker run now-php-docker-image /bin/cat /usr/lib64/libfontconfig.so.1 > ../native/modules/libfontconfig.so.1
docker run now-php-docker-image /bin/cat /usr/lib64/libtiff.so.3 > ../native/modules/libtiff.so.3
docker run now-php-docker-image /bin/cat /usr/lib64/libwebp.so.5 > ../native/modules/libwebp.so.5
# GD End
docker run now-php-docker-image /bin/cat /usr/lib64/php/modules/opcache.so > ../native/modules/opcache.so
docker run now-php-docker-image /bin/cat /usr/lib64/libargon2.so.0 > ../native/libargon2.so.0

while read module; do
  docker run now-php-docker-image /bin/cat /usr/lib64/php/modules/$module.so > ../native/modules/$module.so
done <php-modules.conf

sed -i'.original' 's#/root/app/modules/#/root/app/native/modules/#g' ../native/php.ini

chmod +x ../native/php-fpm
chmod +x ../native/php

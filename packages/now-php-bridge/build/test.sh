mkdir -p /root/app/modules
cp /usr/bin/php /root/app/php
cp /usr/sbin/php-fpm /root/app/php-fpm
cp /usr/lib64/php/modules/* /root/app/modules
cp /usr/lib64/mysql/libmysqlclient.so.16 /root/app/modules/libmysqlclient.so.16
rm -rf $(which php)
rm -rf $(which php-fpm)
rm -rf /usr/lib64/php
rm -rf /usr/lib64/mysql
rm -rf /etc/php.d
./php-fpm --help
./php -c php.ini test.php
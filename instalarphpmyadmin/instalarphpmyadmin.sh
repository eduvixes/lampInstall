
# instalar phpmyadmin

wget https://files.phpmyadmin.net/phpMyAdmin/5.1.1/phpMyAdmin-5.1.1-all-languages.tar.gz
tar xvf phpMyAdmin-5.1.1-all-languages.tar.gz
mv phpMyAdmin-5.1.1-all-languages /usr/share/phpmyadmin
mkdir -p /var/lib/phpmyadmin/tmp
chown -R www-data:www-data /var/lib/phpmyadmin
cp ./config.inc.php /usr/share/phpmyadmin/config.inc.php

cp ./phpmyadmin.conf /etc/apache2/conf-available/phpmyadmin.conf

## ===========================================================================================

/sbin/a2enconf phpmyadmin.conf

systemctl reload apache2

# crear usuario pma de gestion del phpmyadmin
echo "create user 'pma'@'localhost' identified by 'pmaphpmyadmin';" > sqltemp.sql
echo "grant all privileges on phpmyadmin.* to 'pma'@'localhost';" > sqltemp.sql
echo "FLUSH PRIVILEGES;" >> sqltemp.sql
echo "quit;" >> sqltemp.sql

mysql -h localhost -u root < sqltemp.sql
rm sqltemp.sql

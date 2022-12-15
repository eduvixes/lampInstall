# jrodeiro
# 14/12/2022
# Instalacion lamp en debian 11.

# actualizamos el sistema.
apt update && apt -y upgrade

# instalamos ssh
apt install ssh

# instalamos vim
apt install vim

# instalamos Apache (está en los repositorios oficiales)
apt install apache2 apache2-utils

# verificar
# systemctl status apache2

# Habilitamos el inicio automático de Apache al reiniciar nuestro sistema.
systemctl enable apache2

# Configuramos www-data (usuario de Apache) como propietario de la raíz web. Por defecto es el usuario root.
chown www-data:www-data /var/www/html/ -R

# Por defecto Debian 10 viene con MariaDB 10.3.15.
apt install mariadb-server mariadb-client

# Una vez instalado verificamos.
# systemctl status mariadb

# Habilitamos el inicio automático de MariaDB al reiniciar nuestro sistema.
systemctl enable mariadb

# Es importante que asegures la instalación.
mysql_secure_installation

# Puedes comprobar la version instalada.
mariadb --version

# crear usuario con privilegios root
echo "CREATE USER 'admin'@'localhost' IDENTIFIED BY 'iu';" > sqltemp.sql
echo "GRANT ALL PRIVILEGES ON * . * TO 'admin'@'localhost';" >> sqltemp.sql
echo "FLUSH PRIVILEGES;" >> sqltemp.sql
echo "quit;" >> sqltemp.sql

mysql -h localhost -u root < sqltemp.sql
rm sqltemp.sql

# Por defecto se instala la última versión estable de PHP que nos aporta una mejora en el rendimiento respecto a sus versiones anteriores.
# puede hacerse con apt install php (e instala lo mismo)
# apt install php7.4 libapache2-mod-php7.4 php7.4-mysql php-common php7.4-cli php7.4-common php7.4-json php7.4-opcache php7.4-readline

apt install php

apt install php-mysql

apt install php-mbstring php-xml

# Una vez instalado, debes habilitar el módulo Apache php7.4 y reiniciar el servidor web.
# para instalar a2enmod

apt install mlocate
updatedb

/sbin/a2enmod php7.4

systemctl restart apache2

# instalar adminer

wget "http://www.adminer.org/latest.php" -O /var/www/html/adminer.php
chown www-data:www-data /var/www/html/adminer.php

# instalar phpmyadmin
chmod +x ./instalarphpmyadmin/instalarphpmyadmin.sh
./instalarphpmyadmin/instalarphpmyadmin.sh

# actualices de nuevo todo el sistema.
apt update && apt -y upgrade

# reiniciamos el sistema.
# systemctl reboot


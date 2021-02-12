#!/bin/bash

SAISIE=""

function miseAJour() {
	sudo dnf check-update && sudo dnf update
}

while true;
do
	clear
	echo "1. Installer un LAMP (Apache, MySQL, PHP)"
	echo "2. Installer PHPMyAdmin"
	echo "3. Désinstaller le LAMP"
	echo "4. Désinstaller PHPMyAdmin"
	echo "Q. Quitter"

	echo -n "Choisissez une option ci-dessus: "
	read SAISIE

	case $SAISIE in
       	1)
		miseAJour
                sudo dnf install httpd httpd-manual php php-pecl-xdebug3 mariadb-server -y
		sudo mv /etc/httpd/conf.d/welcome.conf /etc/httpd/conf.d/welcome.conf.mv

		sudo systemctl start httpd
		sudo systemctl start mariadb
		sudo systemctl enable httpd
		sudo systemctl enable mariadb

		sudo mysql_secure_installation

		sudo chown -R $USER:$USER /var/www/html/
		touch /var/www/html/info.php
                echo "<?php phpinfo(); ?>" > /var/www/html/info.php
        ;;

        2)
		miseAJour
                sudo dnf install phpMyAdmin -y
		sudo systemctl restart httpd
        ;;

        3)
                sudo dnf autoremove httpd httpd-manual php php-pecl-xdebug3 mariadb-server -y
		rm /var/www/html/info.php
        ;;

        4)
		sudo dnf autoremove phpMyAdmin -y
        ;;

        q|Q)
		clear
                unset SAISIE
                break
        ;;
        esac
done

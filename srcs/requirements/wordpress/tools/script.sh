#!/bin/sh

attempts=0
while ! mariadb -h$MYSQL_HOST -u$WP_DB_USER -p$WP_DB_PWD $WP_DB_NAME &>/dev/null; do
	attempts=$((attempts + 1))
	if [ $attempts -ge 10 ]; then
		echo "MariaDB connection could not be established."
        exit 1
	fi
    sleep 5
done
echo "MariaDB connected!"

cd /var/www/html/

wget -q https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp

chmod +x /usr/local/bin/wp

wp core download --allow-root

wp config create \
	--dbname=$WP_DB_NAME \
	--dbuser=$WP_DB_USER \
	--dbpass=$WP_DB_PWD \
	--dbhost=$MYSQL_HOST \
	--path=/var/www/html/ \
	--force

wp core install \
	--url=$DOMAIN_NAME \
	--title=$WP_TITLE \
	--admin_user=$WP_ADMIN_USR \
	--admin_password=$WP_ADMIN_PWD \
	--admin_email=$WP_ADMIN_EMAIL \
	--allow-root \
	--skip-email \
	--path=/var/www/html/

wp user create \
	$WP_USR \
	$WP_EMAIL \
	--role=author \
	--user_pass=$WP_PWD \
	--allow-root

wp plugin update --all

wp option update siteurl "https://$DOMAIN_NAME" --allow-root
wp option update home "https://$DOMAIN_NAME" --allow-root


chown -R nginx:nginx /var/www/html/

chmod -R 755 /var/www/html/

php-fpm81 -F
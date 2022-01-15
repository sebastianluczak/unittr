#!/bin/bash
set -e
sleep 5

chmod +x /app/bin/console
mkdir -p /app/var/log
mkdir -p /app/var/cache
touch /app/var/log/dev.log
chmod 777 -R /app/var/
mkdir -p /app/db/data

wget -O composer-setup.php https://getcomposer.org/installer
php composer-setup.php --filename=composer.phar
php composer.phar install
rm composer-setup.php
#php /app/bin/console d:d:c --if-not-exists &&
#php /app/bin/console doctrine:migrations:migrate --no-interaction --allow-no-migration &&
#supervisorctl reread
#supervisorctl update
#supervisorctl start messenger-consume:*
exec "$@"
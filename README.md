# Docker-compose for Magento2, Varnish5, Redis5, MySQL5.7 

### Get your developper account

We need a key for installation by magento site. 
https://developer.magento.com/

After sign up sign in and browse below url.
https://marketplace.magento.com/customer/accessKeys/

Check those keys and memorize as yours.
```text
Public Key: as a Username
Private Key: as a Password
```

### Clone Docker files

https://github.com/bluemooninc/magento-docker-base

Clone and build it.

```text
git clone git@github.com:bluemooninc/magento-docker-base.git
cd magento-docker-base
docker-compose up
```

### Install Composer

```text
docker exec -it apache2 bash
curl -sS https://getcomposer.org/installer -o composer-setup.php
php composer-setup.php --install-dir=/usr/local/bin --filename=composer

composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition /var/www/html/magento
Username: [YOUR-PUBLIC-KEY]
Password: [YOUR-PRIVATE-KEY]
```

### Create database

```text
CREATE DATABASE magento DEFAULT CHARACTER SET utf8mb4;
```

### Magento set up

```
docker exec -it apache2 bash
cd magento

bin/magento setup:install \
--base-url=http://localhost \
--db-host=mysql_host \
--db-name=magento \
--db-user=root \
--db-password=root \
--admin-firstname=admin \
--admin-lastname=admin \
--admin-email=admin@admin.com \
--admin-user=admin \
--admin-password=admin123 \
--language=ja_JP \
--currency=JPY \
--timezone=Asia/Tokyo \
--use-rewrites=1


[SUCCESS]: http://localhost/magento/
[SUCCESS]: http://localhost/magento/admin_?????
```
You can set those parameters after install at core_config_data table.


### Install Cron

php bin/magento cron:install

### Re index

php bin/magento indexer:reindex


### Cache by Redis


Add config setting to magento 
```
docker exec -it apache2 bash
cd magento
bin/magento setup:config:set --cache-backend=redis --cache-backend-redis-server=redis_host
```

Monitering by redis
```text
docker exec -it redis_host bash
redis-cli monitor
```

Trouble shooting

If the browser come up these message. 
```text
An error has happened during application run. See exception log for details.
```
Reset for redis once.

```text
redis-cli flushall
```

### Varnish monitoring

You can check it for varnish cache monitoring via "varnishstat" command.

```text
docker exec -it varnish bash
varnishstat
```

### install Japanese locale

Using CrowedIn locale file and set up

```text
composer require community-engineering/language-ja_jp
```

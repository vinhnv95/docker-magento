#!/usr/bin/env sh

set +x

if [[ ! -z "${JENKINS_DATA}" ]]; then
    cd $JENKINS_DATA/workspace/$JOB_BASE_NAME
fi

# Build script here
COMPOSE_FILE="magento-$MAGENTO_VERSION/$HTTP_SERVER/docker-compose.php-$PHP_VERSION.yml"
if [ ! -f "$COMPOSE_FILE" ]; then
    echo "We do not support for Magento $MAGENTO_VERSION on $HTTP_SERVER with php $PHP_VERSION"
    exit 1
fi

HASH_NAME=`echo -n "$HTTP_SERVER-$PHP_VERSION-$MAGENTO_VERSION-$GITHUB_REPO-$GITHUB_BRANCH" | sha1sum | cut -d' ' -f 1`

if [ -d "$HASH_NAME" ]; then
    echo 'Server is running...'
    sleep $TIME_TO_LIVE
    exit
fi

mkdir $HASH_NAME && cd $HASH_NAME

# TODO: Build WebPOS and deploy to Magento Server
env

# Start service
cp ../$COMPOSE_FILE docker-compose.yml
docker-compose -p $HASH_NAME up -d

PORT=`docker-compose -p $HASH_NAME port --protocol=tcp magento 80 | sed 's/0.0.0.0://'`
MAGENTO_URL="http://$NODE_IP:$PORT/"

PORT=`docker-compose -p $HASH_NAME port --protocol=tcp phpmyadmin 80 | sed 's/0.0.0.0://'`
PHPMYADMIN_URL="http://$NODE_IP:$PORT/"

PORT=`docker-compose -p $HASH_NAME port --protocol=tcp mailhog 8025 | sed 's/0.0.0.0://'`
EMAIL_URL="http://$NODE_IP:$PORT/"

# TODO: Install Magento with correct url

# Output URLs
echo "Magento: $MAGENTO_URL"
echo "Admin: admin/admin123"
echo "PHPMyAdmin: $PHPMYADMIN_URL"
echo "EMAIL: $EMAIL_URL"

# Living time
sleep $TIME_TO_LIVE

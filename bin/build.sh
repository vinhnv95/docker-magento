#!/usr/bin/env sh

set +x

if [[ ! -z "${JENKINS_DATA}" ]]; then
    cd $JENKINS_DATA/workspace/$JOB_BASE_NAME
fi

# Build script here
HASH_NAME=`echo -n "$HTTP_SERVER-$PHP_VERSION-$MAGENTO_VERSION-$GITHUB_REPO-$GITHUB_BRANCH" | sha1sum | cut -d' ' -f 1`

if [ -d "$HASH_NAME" ]; then
    echo 'Server is running...'
    sleep $TIME_TO_LIVE
    exit
fi

mkdir $HASH_NAME && cd $HASH_NAME

# TODO: Start service
env

# Living time
sleep $TIME_TO_LIVE

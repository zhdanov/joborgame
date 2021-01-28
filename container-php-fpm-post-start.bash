#!/bin/bash

if nc -z -w2 gitlab-prod.gitlab-prod 80 2>/dev/null
then

    printf "Host gitlab-prod.gitlab-prod\n\tStrictHostKeyChecking no\n\tUserKnownHostsFile=/dev/null\n" >> /etc/ssh/ssh_config

    if [[ ! -d /var/www/joborgame-backend ]]; then
        git clone git@gitlab-prod.gitlab-prod:$HOME_USER_NAME/joborgame-backend.git /var/www/joborgame-backend
    fi

    [ -d /usr/local/composer-store ] && rm -rf /usr/local/composer-store && mkdir -p /usr/local/composer-store

    git clone git@gitlab-prod.gitlab-prod:$HOME_USER_NAME/hangar.git /usr/local/composer-store/hangar
    pushd /usr/local/composer-store/hangar
        git archive --format zip --output ../hangar.zip master
    popd


    git clone git@gitlab-prod.gitlab-prod:$HOME_USER_NAME/samovar.git /usr/local/composer-store/samovar
    pushd /usr/local/composer-store/samovar
        git archive --format zip --output ../samovar.zip master
    popd

    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
    pushd /var/www/joborgame-backend
        git checkout 3.0
        composer install
        make install
    popd
fi

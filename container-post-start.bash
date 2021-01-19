#!/bin/bash

if nc -z -w2 gitlab-$ENVIRONMENT.gitlab-$ENVIRONMENT.svc.cluster.local 80 2>/dev/null
then
    if [[ ! -d /var/www/joborgame-backend ]]; then
        git clone git@gitlab-$ENVIRONMENT.gitlab-$ENVIRONMENT.svc.cluster.local:$HOME_USER_NAME/joborgame-backend.git /var/www/joborgame-backend
    fi
fi

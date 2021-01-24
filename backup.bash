#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "usage:"
    echo "./backup.bash user"
    exit 0
fi

HOME_USER_NAME=$1
SERVICE_NAME=joborgame-prod

if kubectl -n $SERVICE_NAME get statefulsets.apps | grep -q $SERVICE_NAME; then
    if [[ $(dirname "$0") =~ (.*)/(.*)/(.*)$ ]]; then
        BACKUP_FILE_NAME="${BASH_REMATCH[2]}-${BASH_REMATCH[3]}-backup.tar"
        kubectl -n $SERVICE_NAME exec -it $SERVICE_NAME-0 -c mongodb -- mongodump --out=/data/db/dump
        mv /home/$HOME_USER_NAME/data-store/$SERVICE_NAME/joborgame-mongodb/dump /home/$HOME_USER_NAME/data-store/$SERVICE_NAME/
        pushd /home/$HOME_USER_NAME/data-store/$SERVICE_NAME/
            zip -r dump.zip dump
            tar cvf $BACKUP_FILE_NAME dump.zip
            rm -rf dump dump.zip
        popd
    fi
fi

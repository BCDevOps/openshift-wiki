#!/bin/bash
if ! whoami &> /dev/null; then
  if [ -w /etc/passwd ]; then
    echo "${USER_NAME:-default}:x:$(id -u):0:${USER_NAME:-default} user:${HOME}:/sbin/nologin" >> /etc/passwd
  fi
fi
exec "$@"

## Uncomment this if you wish to clone a remote repo and branch into docs
# git clone -b  $BRANCH $GIT_URL docs
# cd docs

## Use this code if you wish to build locally from /docs
cd /opt/app-root/docs

gitbook serve

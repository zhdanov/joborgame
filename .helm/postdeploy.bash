#!/bin/bash

./../hakunamatata/container/container__make-alias.bash joborgame-prod php-fpm
./../hakunamatata/container/container__copy-dotfiles.bash joborgame-prod php-fpm

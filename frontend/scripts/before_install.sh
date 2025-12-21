#!/bin/bash

rm -rf /var/www/html/*

if ! command -v nginx &> /dev/null; then
    amazon-linux-extras install nginx1 -y
fi

exit 0
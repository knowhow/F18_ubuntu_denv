#!/bin/bash

if [[ "$1" == "" ]]; then
    echo "usage  : $0 <profil>" 
    echo "example: $0 pos" 
    exit -1
fi

sudo chef-solo -j solo/$1.json -c solo/$1.rb

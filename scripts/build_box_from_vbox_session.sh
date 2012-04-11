#!/bin/bash

echo pravim gui vagrant box na osnovu postojece virtualbox sesije $1

vagrant package --vagrantfile Vagrantfile.pkg --base $1 --output $1.box

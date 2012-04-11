#!/bin/bash

#apt-get install -y vim
#apt-get remove vim-tiny

#aptitude install -y ruby1.9.1 ruby1.9.1-dev make &&         sudo gem1.9.1 install --no-rdoc --no-ri chef --version 0.10.0

# Setup sudo to allow no-password sudo for "admin"
#cp /etc/sudoers /etc/sudoers.orig
#sed -i -e '/Defaults\s\+env_reset/a Defaults\texempt_group=admin' /etc/sudoers
#sed -i -e 's/%admin ALL=(ALL) ALL/%admin ALL=NOPASSWD:ALL/g' /etc/sudoers


groupadd admin
useradd vagrant -m
usermod -a -G admin vagrant -s /bin/bash

mkdir -p /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
cd /home/vagrant/.ssh

echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" > authorized_keys

chown -R vagrant /home/vagrant/.ssh


# izbriši ovo da se prilikom izmjene MAC adrese ne bi promjenio raspored eth uređaja 
rm /etc/udev/rules.d/70-persistent-net.rules 


# Zero out the free space to save space in the final image:
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

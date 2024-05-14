#!/usr/bin/bash

### UBUNTU.22.04 JOIN AD

##### PRE-REQUIS
# - être connecté au wifi invite

##### VARS
DOMAIN="XXXXXX"
DNS=""
ADMIN=""
OU=""

## installer package joinAD
sudo apt install sssd-ad sssd-tools realmd

## setup le DNS
# stoper service systemd-resolved
sudo systemctl stop systemd-resolved

# ecrire dans /etc/resolv.conf
echo "search $DOMAIN" > /etc/resolv.conf
echo "nameserver 10.231.40.82" >> /etc/resolv.conf

# se connecter au wifi TEAM
nmcli device wifi connect TEAM password 'team2022'

## join AD
sudo realm -v discover $DOMAIN

#
sudo realm join $DOMAIN --user=$ADMIN --computer-ou="OU=Linux,OU=Portables,OU=Ordinateurs,DC=humans,DC=local humans.local" --install=/
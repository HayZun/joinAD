#!/usr/bin/bash

### UBUNTU.22.04 JOIN AD

##### PRE-REQUIS
# - être connecté au wifi invite

##### VARS
DOMAIN="XXXXXX"
DNS=""
ADMIN=""
OU=""
SSID_WIFI_AD=""
PASSWORD_WIFI_AD=""
## installer package joinAD
sudo apt install sssd-ad sssd-tools realmd

## setup le DNS
# stoper service systemd-resolved
sudo systemctl stop systemd-resolved

# ecrire dans /etc/resolv.conf
echo "search $DOMAIN" > /etc/resolv.conf
echo "nameserver $DNS" >> /etc/resolv.conf

# se connecter au wifi TEAM
nmcli device wifi connect $SSID_WIFI_AD password $PASSWORD_WIFI_AD

## join AD
sudo realm -v discover $DOMAIN


sudo realm join $DOMAIN --user=$ADMIN --computer-ou="OU=Linux,OU=Portables,OU=Ordinateurs,DC=humans,DC=local humans.local" --install=/
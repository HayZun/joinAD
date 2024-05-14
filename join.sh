#!/usr/bin/bash

### UBUNTU.22.04 JOIN AD

##### PRE-REQUIS
# - être connecté au wifi invite
# - avoir les packages apt "sssd-ad sssd-tools realmd" installé

##### VARS

# config
DOMAIN="XXXXXX"
DNS=""

# AD
ADMIN_DCA=""
PASSWORD_DCA=""
OU_PATH_COMPUTERS=""

## wifi
SSID_WIFI_AD=""
PASSWORD_WIFI_AD=""

# se connecter au wifi TEAM
nmcli device wifi connect $SSID_WIFI password $PASSWORD_WIFI

## setup le DNS
# stoper service systemd-resolved
systemctl stop systemd-resolved

# ecrire dans /etc/resolv.conf
echo "search $DOMAIN" > /etc/resolv.conf
echo "nameserver $DNS" >> /etc/resolv.conf

## join AD
realm -v discover $DOMAIN

#
echo $PASSWORD_DCA | realm join --user=$ADMIN_DCA --computer-ou=$OU_PATH_COMPUTERS $DOMAIN
#!/bin/bash

SIZE="${1}G";
FILE_SWAP=/swapfile_$SIZE.img;

echo $FILE_SWAP

cd /media
sudo touch $FILE_SWAP;
sudo fallocate -l $SIZE ./$FILE_SWAP;
sudo mkswap ./$FILE_SWAP;
sudo swapon -p 20 ./$FILE_SWAP;

sudo echo "/media/$FILE_SWAP    none    swap    sw,pri=10       0       0" >> /etc/fstab


echo " - reboot needed -"

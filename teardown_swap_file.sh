ILE_NAME=swapfile_${1}G.img

cd /media

sudo swapoff ./$FILE_NAME;
sudo rm ./$FILE_NAME;

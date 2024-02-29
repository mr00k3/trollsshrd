#!/bin/bash
ramdisk_path="SSHRD_Script"

if [ "$(id -u)" != "0" ]; then
	echo "This script must be run as root" 1>&2
	exit 1
fi

cleanup() {
	echo "Interrupt signal caught. Stopping and killing procceses"
	sudo pkill -9 iproxy
	sudo pkill -9 usbmuxd
	exit
}

trap cleanup INT

echo "What is your iOS version? e.g. 15.8"
read iosversion

sudo pkill -9 iproxy
sudo pkill -9 usbmuxd
sudo systemctl stop usbmuxd
sudo usbmuxd -p & disown
clear

if [ -d "$ramdisk_path" ]; then
	echo "[*] Ramdisk exists, skipping download"
	# Enter DFU mode
    echo "[*] Connect phone to pc"
    echo "[*] Unlock phone"
    echo "[*] Press any key when ready for DFU mode"
    echo "[*] After pressing any key hold volume down and power button for 8 seconds then release power button"
    read -s -n 1
    echo "[*] 8s" && sleep 1s
    echo "[*] 7s" && sleep 1s
    echo "[*] 6s" && sleep 1s
    echo "[*] 5s" && sleep 1s
    echo "[*] 4s" && sleep 1s
    echo "[*] 3s" && sleep 1s
    echo "[*] 2s" && sleep 1s
    echo "[*] 1s" && sleep 1s
    echo "[*] Release power button but hold volume down"
	echo "If you see "Waiting for device in DFU mode" for long time or apple just ctrl+c and start script again"
    # SSHRD
	cd SSHRD_Script
    sudo ./sshrd.sh $iosversion
	echo "[*] Booting ramdisk"
    sudo ./sshrd.sh boot
    sleep 10s
    sudo iproxy 2222 22 &
    sleep 4s
    sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p 2222 -t root@localhost 'mount_filesystems; exit'
    sleep 10s
    sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p 2222 -t root@localhost 'cd / && chmod +x trollinstall.sh && sh trollinstall.sh; exit'
    sleep 10s
else
	# Download sshrd
	git clone https://github.com/verygenericname/SSHRD_Script --recursive

	# Download trollstore

	wget https://github.com/opa334/TrollStore/releases/download/2.0.12/PersistenceHelper_Embedded
	wget https://github.com/opa334/TrollStore/releases/download/2.0.12/TrollStore.tar

	# Change name of persistancehelper

	mv -v PersistenceHelper_Embedded PersistenceHelper

	# Untar TrollStore.tar then copy trollstorehelper to dir
	tar -xf TrollStore.tar
	cp TrollStore.app/trollstorehelper .

	# dirs for sshtars
	cd SSHRD_Script/ && cd sshtars/
	mkdir usr
	cd usr
	mkdir bin
	mkdir trollstore
	cd ../../..

	# copy files to dirs
	cp PersistenceHelper SSHRD_Script/sshtars/usr/trollstore/
	cp trollstorehelper SSHRD_Script/sshtars/usr/trollstore/
	cp trollinstall.sh SSHRD_Script/sshtars
	cp trollstoreinstaller SSHRD_Script/sshtars/usr/bin/

	# Adding files to ramdisk

	cd SSHRD_Script/sshtars
	gunzip ssh.tar.gz
	tar --delete -f ssh.tar usr/trollstore/PersistenceHelper
	tar --delete -f ssh.tar usr/trollstore/trollstorehelper
	tar --delete -f ssh.tar usr/bin/trollstoreinstaller
	tar -rvf ssh.tar usr/bin/trollstoreinstaller
	tar -rvf ssh.tar usr/trollstore/PersistenceHelper
	tar -rvf ssh.tar usr/trollstore/trollstorehelper
	tar -rvf ssh.tar trollinstall.sh
	gzip ssh.tar && cd ..

	# Enter DFU mode
	echo "[*] Connect phone to pc"
	echo "[*] Unlock phone"
	echo "[*] Press any key when ready for DFU mode"
	echo "[*] After pressing any key hold volume down and power button for 8 seconds then release power button"
	read -s -n 1
	echo "[*] 8s" && sleep 1s
	echo "[*] 7s" && sleep 1s
	echo "[*] 6s" && sleep 1s
	echo "[*] 5s" && sleep 1s
	echo "[*] 4s" && sleep 1s
	echo "[*] 3s" && sleep 1s
	echo "[*] 2s" && sleep 1s
	echo "[*] 1s" && sleep 1s
	echo "[*] Release power button but hold volume down"
	echo "If you see "Waiting for device in DFU mode" for long or apple logo just ctrl+c and start script again"
	# SSHRD
	sudo ./sshrd.sh $iosversion
	sudo ./sshrd.sh boot
	sleep 10s
	sudo iproxy 2222 22 &
	sleep 3s
	sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p 2222 -t root@localhost 'mount_filesystems; exit'
	sleep 6s
	sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p 2222 -t root@localhost 'cd / && chmod +x trollinstall.sh && sh trollinstall.sh; exit'
	sleep 10s
fi

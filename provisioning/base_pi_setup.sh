#!/bin/bash

# Set up a Raspberry Pi with the basic infrastructure used by ODM360
# Normally followed by a second script which sets up either a Parent or Child

echo updating
sudo apt update && sudo apt upgrade -y

echo Installing ODM infrastructure
sudo apt install -y git python3-pip libgphoto2-dev libatlas-base-dev gfortran

echo Installing emacs because it is the best editor and IDE. You are welcome.
sudo apt install -y emacs-nox

echo Installing posgresql
sudo apt install -y postgresql postgresql-contrib libpq-dev

# TODO check if already done before sedding in the disable flag
echo Disabling IPv6
sudo sed -i '$s/$/ ipv6.disable=1/' /boot/cmdline.txt

echo Disabling serial console to free up UART serial line
sudo sed -i 's/console=serial0,115200 //g' /boot/cmdline.txt

# TODO check if already done before pushing this line into the file
echo enabling UART
echo $'\n# Enable UART\nenable_uart=1' | sudo tee -a /boot/config.txt

echo Installing requirements from setup.py using pip
pip3 install -e .

echo ##########################################################
echo Now you should have a Raspberry Pi set up with the basic infrastructure common to all devices in the kit. The next steps depend whether this device is intended to be a Parent or Child.
echo ##########################################################
echo
#!/bin/bash


# First install Termux on android, then run this script
pkg install python2 -y
pip2 install awscli --upgrade --user
python2 setup.py install

touch ~/.bashrc


# Create alias p and pass
WRAPPER_FILE=`realpath passer-wrapper-android.sh`
echo "alias pass=\"bash $WRAPPER_FILE\"" >> ~/.bashrc
echo "alias p=\"bash $WRAPPER_FILE\"" >> ~/.bashrc

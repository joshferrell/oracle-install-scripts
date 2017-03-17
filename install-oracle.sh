#!/bin/bash

# Make sure that the user is in sudo mode
if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

# Get Local user
echo "Enter your current user account. It must be one of the following list:"
ls /Users | awk '!/Guest/ && !/Shared/ && !/administrator/ && /^([^\.]*)$/'
read UserName

if [ -d "/opt/oracle" ]; then
    echo "There exists an /opt/oracle directory would you like to remove it? (y/n)"
    read deleteOptions

    if [ "{$deleteOptions,,}" == *"y"*]; then
        rm -rf /opt/oracle
    fi
fi

echo "Creating the oracle directory in root."
mkdir -p /opt/oracle

echo "Unzipping oracle instant client packages."
unzip ./instantclient-basic-macos.x64-12.1.0.2.0.zip
unzip ./instantclient-sdk-macos.x64-12.1.0.2.0.zip

mv ./instantclient_12_1 /opt/oracle/instantclient
cd /opt/oracle/instantclient

ln -s libclntsh.dylib.12.1 libclntsh.dylib

export OCI_LIB_DIR=/opt/oracle/instantclient
export OCI_INC_DIR=/opt/oracle/instantclient/sdk/include

commandExists="$(command -v n)"
if [[ -z $commandExists ]]; then
    echo "node version manager is not installed"

    commandExists="$(command -v node)"
    if [[ -z $commandExists ]]; then
        echo "node is not installed"

        commandExists="$(command -v brew)"
        if [[ -z $commandExists ]]; then
            echo "Brew is not installed"
            echo "Installing brew..."
            /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        fi

        echo "Installing node..."
        su $UserName -c "brew install node"
    fi

    echo "Installing node version manager..."
    npm install -g n
fi

echo "Installing the latest version of node."
n latest

echo "Installing node version 0.12.17"
n 0.12.17

commandExists="$(command -v python)"
if [[ -z $commandExists ]]; then
    echo "Python is not installed"
    echo "Installing python..."
    su $UserName -c "brew install python"
fi

commandExists="$(command -v g++)"
if [[ -z $commandExists ]]; then
    echo "GCC is not installed"
    echo "Installing gcc..."
    su $UserName -c "xcode-select --install"
fi

printf "\n\n\n\---CONGRATS! YOU'RE NOW READY TO INSTALL ORACLE---"

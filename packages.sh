#!/usr/bin/env bash

# packages.sh - quick install for basic reverse engineering tools, also compiles the current
# release of ghidra 11.4-DEV

# update current packages
sudo apt update -y; sudo apt upgrade -y;

# install packages
sudo apt install \
    open-vm-tools \
    build-essential \
    gdb \
    python3-pip \
    python3-venv \
    python3-protobuf \
    python3-pwntools \
    clang \
    golang \
    curl \
    tmux \
    neofetch \
    xclip \
    vim \
    wireshark \
    nmap \
    ltrace \
    strace \
    binwalk \
    valgrind \
    checksec \
    pipx \
    npm \
    xbindkeys \
    xdotool

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# install pwndbg
wget "https://github.com/pwndbg/pwndbg/releases/download/2025.02.19/pwndbg_2025.02.19_amd64.deb" -O pwndbg.deb;
sudo dpkg -i pwndbg.deb;
rm pwndbg.deb

# install openjdk-21
wget "https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.6%2B7/OpenJDK21U-jdk_x64_linux_hotspot_21.0.6_7.tar.gz"
tar -xvf "./OpenJDK21U-jdk_x64_linux_hotspot_21.0.6_7.tar.gz"
sudo mkdir -v /opt/jdk
sudo mv "jdk-21.0.6+7/" /opt/jdk/
echo 'export PATH=$PATH:/opt/jdk/jdk-21.0.6+7/bin' >> ~/.bashrc
export PATH=$PATH:/opt/jdk/jdk-21.0.6+7/bin
rm -rf 'jdk-21.0.6+7/'
rm OpenJDK21U-jdk_x64_linux_hotspot_21.0.6_7.tar.gz

# install gradle
wget "https://services.gradle.org/distributions/gradle-8.13-bin.zip"
sudo unzip -d /opt/gradle gradle-8.13-bin.zip
rm gradle-8.13-bin.zip
echo 'export PATH=$PATH:/opt/gradle/gradle-8.13/bin' >> ~/.bashrc
export PATH=$PATH:/opt/gradle/gradle-8.13/bin

# install ghidra
git clone https://github.com/NationalSecurityAgency/ghidra.git
cd ghidra
gradle -I gradle/support/fetchDependencies.gradle
gradle buildGhidra
sudo mkdir -pv /opt/ghidra
sudo unzip ./build/dist/ghidra_11.4_DEV_20250320_linux_x86_64.zip -d /opt/ghidra
cd ..
sudo mv ghidra "/opt/ghidra/source"
echo 'alias ghidra=/opt/ghidra/ghidra_11.4_DEV/ghidraRun' >> ~/.bashrc
alias ghidra=/opt/ghidra/ghidra_11.4_DEV/ghidraRun

# install nvim
wget "https://github.com/neovim/neovim/releases/download/v0.10.4/nvim-linux-x86_64.tar.gz"
tar -xvf nvim-linux-x86_64.tar.gz
sudo mv nvim-linux-x86_64 /opt/
echo 'export PATH=$PATH:/opt/nvim-linux-x86_64/bin' >> ~/.bashrc
export PATH=$PATH:/opt/nvim-linux-x86_64/bin

# python packages
pipx install ROPgadget
pipx install ropper

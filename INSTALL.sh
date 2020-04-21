#!/bin/bash
echo "Installing Dependencies"
sudo apt-get install golang -y

cd /.
cd /opt/
echo "Installing AssetFinder"
go get -u github.com/tomnomnom/assetfinder
echo "Installing HTTProbe"
go get -u github.com/tomnomnom/httprobe
echo "Installing Amass"
export GO111MODULE=on
go get -v -u github.com/OWASP/Amass/v3/...
$GOPATH/bin
echo "Installing AssetCon"
git clone https://github.com/Sreesankar-G-Warrier/AssetCon.git
cd AssetCon/
export PATH="$PATH:."
echo "Installation Completed"

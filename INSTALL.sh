#!/bin/bash

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

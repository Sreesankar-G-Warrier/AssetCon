#!/bin/bash
clear
#                          _    _____            
#       /\                | |  / ____|           
#      /  \   ___ ___  ___| |_| |     ___  _ __  
#     / /\ \ / __/ __|/ _ \ __| |    / _ \| '_ \ 
#    / ____ \\__ \__ \  __/ |_| |___| (_) | | | |
#   /_/    \_\___/___/\___|\__|\_____\___/|_| |_|
#                                     @7r35p4553r                 
#                                                

                                 
figlet -f big AssetCon
echo -ne "By @7r35p4553r\n"

url=$1
host $url > /dev/null
if [ $# -ne 0 ]; then
	echo "[->]Resolving Domain"
if [ $? -ne 1 ]; then
	echo "[*]Domain resolved successfully"
if [ ! -d "$url" ];then
	mkdir $url
fi

if [ ! -d "$url/recon" ];then
	mkdir $url/recon
fi

echo "[+]Starting Assetfinder"
#echo -ne "\r[+]Progress:$u"
#while true
#do
assetfinder $url >> $url/recon/assets.txt | echo "[->]Progressing..."
#u= echo -n "#" 
#sleep 1
#done 
cat $url/recon/assets.txt | grep $1 >> $url/recon/subdomain.txt
rm $url/recon/assets.txt

echo "[+]Starting AMASS"
amass enum -d $url > /dev/null >> $url/recon/a.txt | echo "[->]Progressing..."
sort -u $url/recon/a.txt >> $url/recon/subdomain.txt
rm $url/recon/a.txt

echo "[->]Probing for alive Domains..."
cat $url/recon/subdomain.txt | sort -u $url/recon/subdomain.txt | httprobe -s -p https:443 > /dev/null | sed 's/https\?:\/\///' | tr -d ': 443' >> $url/recon/alive.txt
echo -ne "\n"
if [ -s "$url/recon/subdomain.txt" ]; then
	echo -ne "[+]The collected Subdomains are...\n" & cat -n $url/recon/subdomain.txt & wc -l $url/recon/alive.txt | tr -d ":$url/recon/subdomain.txt"
else
	echo "[-]Sorry there is No Subdomain is available"
fi

if [ -s "$url/recon/alive.txt" ]; then
	echo -ne "[+]The collected Alive Sites are...\n" & cat -n $url/recon/alive.txt & wc -l $url/recon/alive.txt | tr -d ":$url/recon/alive.txt"
else
	echo "[-]Sorry there is No Alive Sites are there"
fi

echo -ne "\n"
echo "[*]This result is saved in the $url folder."

else 
	echo "[!]URL not found"
	echo "[*]Enter a Valid Domain"
fi
else echo "[!]Enter a Domain" 
     echo "[*]Usage:./assestcon.sh www.example.com"
fi

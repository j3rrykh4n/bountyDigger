#!/bin/bash

echo "Enter Your Target Domain:~_~"
read target


echo "[:::start digging in $target:::]"
sleep 2

mkdir $target
cd $target
 
#check ports\
echo "[::checking ports::]"
naabu -host $target -p 80,81,300,443,591,593,832,981,1010,1311,1099,2082,2095,2096,2480,3000,3128,3333,4243,4567,4711,4712,4993,5000,5104,5108,5280,5281,5800,6543,7000,7396,7474,8000,8001,8008,8014,8042,8069,8080,8081,8083,8088,8090,8091,8118,8123,8172,8222,8243,8280,8281,8333,8337,8443,8500,8834,8880,8888,8983,9000,9043,9060,9080,9090,9091,9200,9443,9800,9981,10000,11371,12443,16080,18091,18092,20720,55672 -o ports.txt
sleep 2

#subDomain Enumaretion

echo "[:::Start SubDomain Enumeration:::]"

subfinder -d $target -o finder.txt
amass enum -passive -norecursive -noalts -d $target -o amass.txt
cat finder.txt amass.txt > allsub.txt
sort -u allsub.txt
rm finder.txt amass.txt 

cat allsub.txt | httpx -silent -status-code -mc 200 -o 200.txt
cat allsub.txt | httpx -silent -status-code -mc 301 -o 301.txt
cat allsub.txt | httpx -silent -status-code -mc 403 -o 403.txt
cat allsub.txt | httpx -silent -status-code -mc 404 -o 404.txt

#Checking subdomain ports
echo "::::Checking subdomain ports::::"

naabu -list allsub.txt -p 80,81,300,443,591,593,832,981,1010,1311,1099,2082,2095,2096,2480,3000,3128,3333,4243,4567,4711,4712,4993,5000,5104,5108,5280,5281,5800,6543,7000,7396,7474,8000,8001,8008,8014,8042,8069,8080,8081,8083,8088,8090,8091,8118,8123,8172,8222,8243,8280,8281,8333,8337,8443,8500,8834,8880,8888,8983,9000,9043,9060,9080,9090,9091,9200,9443,9800,9981,10000,11371,12443,16080,18091,18092,20720,55672 -o subdomainPorts.txt


rm allsub.txt
mkdir subdomains
mv 200.txt 403.txt 301.txt 404.txt domains
cd subdomains 

#Gathering SubDomains Urls
echo "[:::collecting subDomains urls:::]"

cat 200.txt | gau --threads 5 -o subUrls.txt  --blacklist png,jpg,gif example.com

#Nuclei-Tech detect                                                  
#cat 200.txt | nuclei -t ~/nuclei-templates/technologies -o tech_res ult.txt
#echo "Detected techonlogies..."
#cat tech_result.txt | notify -provider-config conf.yaml

cd .. 

#urls and parameter discover
echo "[:::Digging for parameter:::]"

gau $target -o urls.txt --blacklist png,jpg,gif
 
#content discovery
echo "[:::fucking endpoint *,*:::]"
gobuster dir -u $target -w $HOME/goldDigger/wordlist.txt -s 200,201,202,203,401,402,403 -b 500,404,301 -o fuzz.txt --wildcard


#result.txt | notify -provider-config conf.yaml 
#write Discord Bot config in yaml
#ToDo

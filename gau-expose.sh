#!/bin/bash


echo -e '\033[1;38;5;221m'"

+-+-+-+ +-+-+-+-+-+-+
|G|a|u| |E|x|p|o|s|e|
+-+-+-+ +-+-+-+-+-+-+
Author:Tamim Hasan(tamimhasan404)"
echo

path=$1

[ ! -f ~/tools/gau-expose/gau-expose-result/$2 ] && mkdir -p ~/tools/gau-expose/gau-expose-result/$2

BASE=/root/tools/gau-expose/gau-expose-result/$2

#cp $path gau-expose-result
#cd gau-expose-result

cat $path | grep ".xls\|.xlsx\|.sql\|.csv\|.env\|.msql\|.bak\|.bkp\|.bkf\|.old\|.temp\|.db\|.mdb\|.config\|.yaml\|.zip\|.tar\|.git\|.xz\|.asmx\|.vcf\|.pem" | uro | sort | uniq  > $BASE/gau-sensitive-file.txt

echo "[] Gathering all panel stuff"

cat $path | grep -i "login\|singup\|admin\|dashboard\|wp-admin\|singin\|adminer\|dana-na\|login/?next/=" | sort | uniq | uro > $BASE/gau-panel.txt
echo
echo "[] Gathering third-party assets"

cat $path | grep -i "jira\|jenkins\|grafana\|mailman\|+CSCOE+\|+CSCOT+\|+CSCOCA+\|symfony\|debug\|gitlab\|phpmyadmin\|phpMyAdmin" | sort | uniq | uro > $BASE/gau-third-party-assets.txt

echo
echo "[] Gathering emails-usersnames"
cat $path | grep "@" | sort | uniq | uro > $BASE/gau-emails-usersnames.txt

echo
echo "[] Gathering error(may sensitive-data-expose)"
cat $path | grep "error." | sort | uniq | uro > $BASE/gau-error-base.txt

echo
echo "[] Gathering other sensitive path"
cat $path | grep -i "root\| internal\| private\|secret" | sort | uniq | uro > $BASE/other-possible-sensitive-path.txt

echo
echo "[] Gathering only robots.txt"
cat $path | grep -i robots.txt | sort | uniq | uro > $BASE/only-robots.txt

echo
echo "[] Gathering subdomains"
cat $path | cut -d'/' -f3 | cut -d':' -f1 | uro | sed 's/^\(\|s\):\/\///g' > $BASE/subdomains.txt

echo
echo "[] Grathering paths for directory brute-force"

cat $path | rev | cut -d '/' -f 1 | rev | uro | sed 's/^\(\|s\):\/\///g' | sed '/=\|.js\|.gif\|.html\|.rss\|.cfm\|.htm\|.jpg\|.mp4\|.css\|.jpeg\|.png\|:\|%/d' > $BASEwordlist.txt

#rm $path

echo

echo -e "\e[1mDone, Hope it's helpful for you\e[0m"

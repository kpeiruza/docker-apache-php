#!/bin/bash -x


mkdir /download
cd /download
if [ -n "$SRCURL" ]
then
	rm -r /var/www/html
	curl -L -k "$SRCURL" > file.tmp
	if [ $(file  file.tmp | grep -c "gzip compressed data") -ne 0 ]
	then
		tar zx < file.tmp
		rm file.tmp
	else
		mv file.tmp file.zip
		unzip file.zip
		rm file.zip
	fi
fi

if [ $(find . -maxdepth 1 -type f  | wc -l) -eq 0 ]
then
	mv $(find . -mindepth 1 -maxdepth 1 -type d) /var/www/html
else
	mkdir /var/www/html
	mv * .[a-z]* /var/www/html
fi

/usr/sbin/apachectl -D FOREGROUND

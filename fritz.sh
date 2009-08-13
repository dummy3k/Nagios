#!/bin/bash 

curl -d "login:command/password=PASS" \
	 -d "getpage=..%2Fhtml%2Finetstat.html" \
	 -s http://exmaple.com/cgi-bin/webcm | awk -f fritz.awk


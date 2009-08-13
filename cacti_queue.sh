#! /bin/bash

cat /var/log/cacti/cacti.log | grep "SYSTEM STATS:" | tail -n1 | awk '{if(match($0,/.*Time:([0-9.]+).*/,x)){print x[1]}}'


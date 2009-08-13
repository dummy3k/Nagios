#!/bin/bash

#/usr/local/nagios/libexec/check_fping $@ | /usr/local/nagios/libexec/cacti_reader
/usr/local/nagios/libexec/check_ping -H $@ -w99,99% -c99,99% | egrep -o [0-9]+\\.[0-9]+

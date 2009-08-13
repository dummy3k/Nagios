#!/usr/bin/perl -w
use strict;

#------------------------------------------------------------------------------
# Daten abrufen
my $url = "http://example.com/cgi-bin/ts.cgi?page=systeminfo&mode=disk";
my $cmd = "lynx -dump -auth=USER:PASS '$url'";
open(DATUM,"$cmd |");
my $line;
my $header = 0;
my $value;

unless ($ARGV[0]) {
	die "1st parameter should be 'RAID Array 1' or 'USB Disk 2'\n";
}
my $device = $ARGV[0];

while ($line = <DATUM>) {
	#print "::$line";
	if ($line =~ "^\\s*$device") {
		#print "found 'RAID Array 1'\n";
		$header = 1;
	}

	if ($header == 1 && $line =~ 'Total Capacity\s+([\d,]+) kbytes') {
		$value = $1;
		$value =~ s/,//g;
		$value *= 1024;
		print "size:$value ";
	}

	if ($header == 1 && $line =~ 'Amount in Use\s+([\d,]+) kbytes') {
		$value = $1;
		$value =~ s/,//g;
		$value *= 1024;
		print "used:$value\n";
	}


	if ($header == 1 && $line =~ '^\s*$') {
		#print "'RAID Array 1' end\n";
		$header = 0;
	}
}

close(DATUM)
  or die "Fehler bei Ausführung von:\n$cmd\n";


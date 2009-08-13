#!/usr/bin/perl -w
use strict;

#------------------------------------------------------------------------------
# Daten abrufen
my $url = "http://example.com/cgi-bin/ts.cgi?page=systeminfo&mode=disk";
my $cmd = "lynx -dump -auth=USER:PASS '$url' | grep 'Status   '";
open(DATUM,"$cmd |");
my $state = <DATUM>;
close(DATUM)
  or die "Fehler bei Ausführung von:\n$cmd\n";

#------------------------------------------------------------------------------
#  Total Space: 476,726,416K
unless ($state =~ /Status\s+(\w+)/) {
	die "bad retval $state\n";
}
$state=$1;

unless ($state =~ 'Normal') {
	print "Bad state '$state'\n";
	exit(2);
}

print "Okay\n";

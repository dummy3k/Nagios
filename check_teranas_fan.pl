#!/usr/bin/perl -w
use strict;

#------------------------------------------------------------------------------
# parameter pruefen
#my $host = $ARGV[0];
#unless (defined($host)) { die "1st parameter 'host' missing"; }

#------------------------------------------------------------------------------
# Daten abrufen
open(DATUM,"lynx -dump -auth=USER:PASS 'http://example.com/cgi-bin/ts.cgi?page=systeminfo&mode=system' | grep 'Fan Status' |");
my $fan = <DATUM>;
close(DATUM)
  or die "Fehler bei Ausführung von 'lynx'\n";

#------------------------------------------------------------------------------
#  Fan Status                              Normal (1158 RPM)
unless ($fan =~ /Fan Status\s+\w+ \((\d+) RPM\)/) {
	die "bad value $fan\n";
}
$fan = $1;
print "$fan\n";


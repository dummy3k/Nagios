#!/usr/bin/perl -w
use strict;

#------------------------------------------------------------------------------
# parameter pruefen
my $host = $ARGV[0];
unless (defined($host)) { die "1st parameter 'host' missing"; }

my $warn = $ARGV[1];
unless (defined($warn)) { die "2nd parameter 'warn' missing"; }

my $critical = $ARGV[2];
unless (defined($critical)) { die "1st parameter 'critical' missing"; }

#------------------------------------------------------------------------------
# Daten abrufen
open(DATUM,"lynx -dump $host | grep Space |");
my $total_space = <DATUM>;
my $available_space = <DATUM>;
close(DATUM)
  or die "Fehler bei Ausführung von 'lynx'\n";

#------------------------------------------------------------------------------
#  Total Space: 476,726,416K
unless ($total_space =~ /Total Space: ([\d,]+)K/) {
	die "bad total space $total_space\n";
}
$total_space = $1;
$total_space =~ s/,//g;
$total_space /= 1024**2;

#------------------------------------------------------------------------------
#Available Space: 149,776,628K
unless ($available_space =~ /Available Space: ([\d,]+)K/) {
	        die "bad available space $available_space\n";
	}
$available_space = $1;
$available_space =~ s/,//g;
$available_space /= 1024**2;

my $used_space = $total_space - $available_space;

#------------------------------------------------------------------------------
# Ausgabe

if ($used_space/$total_space > $critical/100) {
	print "CRITICAL ";
}

if ($used_space/$total_space > $warn/100) {
	print "WARNING ";
}

print "total: ";
printf "%.2f", $total_space;
print " Gb";

print " - free: ";
printf "%.2f", $available_space;
print " Gb (";
printf "%.2f", $available_space/$total_space*100;
print "%)";

print " - used: ";
printf "%.2f", $used_space;
print " Gb (";
printf "%.2f", $used_space/$total_space*100;
print "%)";

#Ende im Gelaende...
print "\n";

if ($used_space/$total_space > $critical/100) {
	exit(2);
}

if ($used_space/$total_space > $warn/100) {
	exit(1);
}

#total: 57,26 Gb - used: 13,64 Gb (24%) - free 43,62 Gb (76%)

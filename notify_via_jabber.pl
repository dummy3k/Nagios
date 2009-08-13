#!/usr/bin/perl
#
# Author David Cox
# Created from various code examples found on the web
# Last Modified 08/06/2002
# Feel free to use or modify as needed to suit your needs
#######################################################
# MAXWAIT is used because the send message function didn't seem to
# like being called to fast. The message would be sent unless I waited a second
# or so. You can experiment with it but I just went with 2 seconds.
#######################################################

use strict;
use Net::Jabber qw(Client) ;
use Net::Jabber qw(Message) ;
use Net::Jabber qw(Protocol) ;
use Net::Jabber qw(Presence) ;

my $len = scalar @ARGV;

if ($len ne 2) {
   die "Usage...\n notify [jabberid] [message]\n";
}

my @field=split(/,/,$ARGV[0]);

use constant RECIPIENT => $ARGV[0];
use constant SERVER    => 'CHANGE_ME';
use constant PORT      => 5222;
use constant USER      => 'CHANGE_ME';
use constant PASSWORD  => 'CHANGE_ME';
use constant RESOURCE  => 'CHANGE_ME';
use constant MESSAGE   => $ARGV[1];
use constant MAXWAIT   => 2 ;

my $connection = Net::Jabber::Client->new();
$connection->Connect( "hostname" => SERVER,"port" => PORT )  or die
"Cannot connect ($!)\n";

my @result = $connection->AuthSend( "username" => USER,"password" =>
PASSWORD,"resource" => RESOURCE );
if ($result[0] ne "ok") {
 die "Ident/Auth with server failed: $result[0] - $result[1]\n";
}

foreach ( @field ) {
   my $message = Net::Jabber::Message->new();
   $message->SetMessage( "to"           => $_,
#                         "subject"      => "Notification",
                         "type"         => "chat",
                         "body"         => MESSAGE);

   $connection->Send($message);
   sleep(MAXWAIT);
}
$connection->Disconnect();
exit;


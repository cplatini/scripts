#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: stall_cleaner.pl
#
#        USAGE: ./stall_cleaner.pl  
#
#  DESCRIPTION: Removes hung processes from engine builds
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: Threshold set to when a log file is over 50000.
#				Need to change the logdir variable to YOUR logdir!
#       AUTHOR: |Eric Musican| (), 
# ORGANIZATION: CHO
#      VERSION: 1.0
#      CREATED: 12/15/2015 02:03:19 PM
#     REVISION: 1
#===============================================================================

use strict;
use warnings;
use utf8;
use POSIX qw(setsid);
use LWP::Simple;


### Misc ###
# flush the buffer
#$| = 1;

# daemonize the program
#&daemonize;

### Variable Declarations ##
my $date = qx(date +%Y%m%e-%k:%M:%S);
my $val;
my $logdir = '/home/emusican-cho/scripts/provisioning/bin/nlp-build-out';
my @servers = qx(ps aux \| grep nlpd \| awk '{print \$16}');
chomp(@servers);
@servers = grep { $_ ne '' } @servers;

### Open Log  - Not use Perl module to not modify the default module path ###
open(my $LOG, ">>", "/tmp/stall_cleaner.log") or die "cannot open > stall_cleaner.log for writing: $!";
print $LOG "$date";
print $LOG "Scanning for stalled engine builds...\n";

### Main Loop ###
#while(1) {
    foreach my $server(@servers) {
        if ($server=~m/nlpd-/) {   ### if server matches 'nlpd-'
            $val = qx(ls -lrt $logdir/$server\.out | awk '{print \$5}');  ### gathers name of server
            if ($val > '50000') {  ### threshold of logfile set to 50000
                clean($server);
            }
        }
    }
#}

### Subroutines ###
sub clean {
    my $server = shift;
    print $LOG "Server $server needs cleaning!\n";
    my $killval = qx(ps aux \| grep $server \| grep -v grep | awk '{print \$2}');
    chomp($killval);
    my $ip = qx(grep ADDRESS $logdir/$server\.out \| awk '{print \$3}');
    chomp($ip);
    my $killval2 = qx(ps aux \| grep $ip \| grep -v grep \| awk '{print \$2}');
    chomp($killval2);
    print $LOG "Killing pids $killval and $killval2 associated with $server\n";
    qx(kill -9 $killval $killval2);
    print $LOG "$server has been cleaned\n";
}

sub daemonize {
    chdir '/' or die "Can’t chdir to /: $!";
    open STDIN, '/dev/null' or die "Can’t read /dev/null: $!";
    open STDOUT, '>>/dev/null' or die "Can’t write to /dev/null: $!";
    open STDERR, '>>/dev/null' or die "Can’t write to /dev/null: $!";
    defined(my $pid = fork) or die "Can’t fork: $!";
    exit if $pid;
    setsid or die "Can’t start a new session: $!";
    umask 0;
}

exit 0;

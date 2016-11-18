use v5.10;
use strict;
use warnings;

use EnvCheck;
use Gearman::Client;
use Getopt::Long;

GetOptions(
    "host=s"      => \my $host,
    "port=i"      => \my $port,
    "iteration=i" => \my $iteration,
    "ssl"         => \my $use_ssl,
    "start=i"     => \my $start,
    "timeout=i"   => \my $timeout,
);

$iteration ||= 0;
$start     ||= 0;
$timeout   ||= 0;

my %args = (
    job_servers => [(join ':', $host, $port)]
);

if ($use_ssl) {
    $args{use_ssl}       = 1;
    $args{ssl_socket_cb} = $EnvCheck::SSL_CB,;
}

{
    my $client = Gearman::Client->new(%args);
    my $func   = "sequence-of-chars";
    my $max    = $start + $iteration;
    my $i      = 0;

    local $SIG{ALRM} = sub { die sprintf "%s($i) timed out", $func };
    alarm $timeout;

    for ($start .. $max) {
        $i = $_;

        my $r = $client->do_task($func => $i);

        my $v = length(${$r});
        $v == $i || die "$func result of length $v != $i";
    } ## end for ($start .. $max)

    alarm 0;
}

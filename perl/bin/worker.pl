use v5.10;
use strict;
use warnings;

use EnvCheck;
use Gearman::Worker;
use Getopt::Long;

GetOptions(
    "host=s"    => \my $host,
    "port=i"    => \my $port,
    "ssl"       => \my $use_ssl,
    "timeout=i" => \my $timeout,
);

$timeout ||= 0;

my %args = (
    job_servers => [(join ':', $host, $port)],
    debug       => 0,
);

if ($use_ssl) {
    $args{use_ssl}       = 1;
    $args{ssl_socket_cb} = $EnvCheck::SSL_CB,;
}

my $func = "sequence-of-chars";
my $w    = Gearman::Worker->new(%args);

$w->register_function(
    $func,
    sub {
        my $l = int($_[0]->arg) || 1;
warn "work $l";
        return 'a' x $l;
    }
);

{
    local $SIG{ALRM} = sub { die "$func timed out" };
    alarm $timeout;

    $w->work(
        stop_if => sub {
            my ($idle, $last_job_time) = @_;
            return $idle;
        }
    );

    alarm 0;
}

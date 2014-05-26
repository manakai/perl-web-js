use strict;
use warnings;
use Path::Tiny;
use JSON::PS;
use Data::Dumper;

my $Data = {};

my $grammer_path = path (__FILE__)->parent->parent->child ('local/webidl-grammer.json');

$Data->{grammer} = (json_bytes2perl $grammer_path->slurp)->{rules};

$Data::Dumper::Sortkeys = 1;
$Data::Dumper::Useqq = 1;
my $pm = Dumper $Data;
$pm =~ s/VAR1/Web::IDL::_Defs/g;
print "$pm\n";

## License: Public Domain.

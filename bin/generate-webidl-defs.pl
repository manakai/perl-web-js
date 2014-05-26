use strict;
use warnings;
use Path::Tiny;
use JSON::PS;
use Data::Dumper;

my $Data = {};

my $grammer_path = path (__FILE__)->parent->parent->child ('local/webidl-grammer.json');
$Data->{grammer} = (json_bytes2perl $grammer_path->slurp)->{rules};

my $data_path = path (__FILE__)->parent->parent->child ('local/webidl.json');
my $data = json_bytes2perl $data_path->slurp;
$Data->{$_} = $data->{$_} for qw(keyword_tokens other_tokens);

for (keys %{$data->{keyword_tokens}}) {
  if ($data->{keyword_tokens}->{$_}->{argument_name}) {
    push @{$Data->{grammer}->{ArgumentNameKeyword}->{patterns} ||= []},
        [{type => $_, set_type => 'name'}];
  }
}

$Data::Dumper::Sortkeys = 1;
$Data::Dumper::Useqq = 1;
my $pm = Dumper $Data;
$pm =~ s/VAR1/Web::IDL::_Defs/g;
print "$pm\n";

## License: Public Domain.

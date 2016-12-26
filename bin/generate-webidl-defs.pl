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

for (sort { $a cmp $b } keys %{$data->{keyword_tokens}}) {
  if ($data->{keyword_tokens}->{$_}->{argument_name}) {
    push @{$Data->{grammer}->{ArgumentNameKeyword}->{patterns} ||= []},
        [{type => $_, set_type => 'name'}];
  }
  if ($data->{keyword_tokens}->{$_}->{attribute_name}) {
    push @{$Data->{grammer}->{AttributeNameKeyword}->{patterns} ||= []},
        [{type => $_, set_type => 'name'}];
  }
}

for my $construct (sort { $a cmp $b } keys %{$data->{constructs}}) {
  $Data->{reserved}->{$construct} = $data->{constructs}->{$construct}->{reserved}
      if $data->{constructs}->{$construct}->{reserved};
  $Data->{allowed_xattrs}->{$construct} = $data->{constructs}->{$construct}->{allowed_extended_attributes}
      if $data->{constructs}->{$construct}->{allowed_extended_attributes};
}

my $disallowed_combinations = {};
for my $name (sort { $a cmp $b } keys %{$data->{extended_attributes}}) {
  $Data->{xattr_args}->{$name} = $data->{extended_attributes}->{$name}->{args};
  $Data->{xattr_multiple}->{$name} = 1 if $data->{extended_attributes}->{$name}->{multiple};
  for my $name2 (sort { $a cmp $b } keys %{$data->{extended_attributes}->{$name}->{disallowed_extended_attributes}}) {
    my @name = sort { $a cmp $b } $name, $name2;
    $disallowed_combinations->{$name[0], $name[1]} = \@name;
  }
}
$Data->{xattr_disallowed} = [map { $disallowed_combinations->{$_} } sort { $a cmp $b } keys %$disallowed_combinations];

$Data::Dumper::Sortkeys = 1;
$Data::Dumper::Useqq = 1;
my $pm = Dumper $Data;
$pm =~ s/VAR1/Web::IDL::_Defs/g;
print "$pm\n";

## License: Public Domain.

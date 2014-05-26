use strict;
use warnings;
use Path::Tiny;
use JSON::PS;

my $Data = {};

my $grammer_path = path (__FILE__)->parent->parent->child
    ('src/webidl-grammer.txt');

my $rule_name;
my $patterns;
for (split /\x0D?\x0A/, $grammer_path->slurp_utf8) {
  if (/^\s*#/) {
    next;

  } elsif (/^\*\s*(\S+)\s*$/) {
    $rule_name = $1;
    push @{$Data->{rules}->{$rule_name}->{patterns} ||= []}, $patterns = [];

  } elsif (defined $rule_name and /^\|$/) {
    push @{$Data->{rules}->{$rule_name}->{patterns} ||= []}, $patterns = [];
  } elsif (defined $rule_name and /^\?$/) {
    $Data->{rules}->{$rule_name}->{can_be_empty} = 1;
  } elsif (defined $rule_name and /^\+pos$/) {
    $Data->{rules}->{$rule_name}->{set_index} = 1;
  } elsif (defined $rule_name and /^\+(\w+)\[\]$/) {
    $Data->{rules}->{$rule_name}->{ensure_arrayref} = $1;
  } elsif (defined $rule_name and /^\+(\w+)="([^"]+)"$/) {
    $Data->{rules}->{$rule_name}->{set} = [$1, $2];
  } elsif (defined $rule_name and /\S/) {
    for (split / /, $_) {
      my $set_name;
      my $set_type;
      my $pattern = {};

      while (s/!'([^']+)'$//) {
        $pattern->{next_is_not}->{$1} = 1;
      }

      if (s/="(\w+)"$//) {
        $pattern->{set_value} = $1;
      } elsif (s/=_"(\w+)"$//) {
        $pattern->{set_value} = $1;
        $pattern->{remove_underscore} = 1;
      } elsif (s/=(\w+)\?$//) {
        $pattern->{set_true} = $1;
      } elsif (s/\*=(\w+)\[\]$//) {
        $pattern->{append} = $1;
        $pattern->{multiple} = 1;
      } elsif (s/=(\w+)\[\]$//) {
        $pattern->{append} = $1;
      } elsif (s/="(\w+)"\[\]$//) {
        $pattern->{append_value} = $1;
      } elsif (s/=(\w+)$//) {
        $pattern->{set} = $1;
      }

      if (/^'([^']*)'$/) {
        $pattern->{type} = $1;

        if (defined $pattern->{set_value}) {
          $pattern->{set_type} = delete $pattern->{set_value};
        }
        if (defined $pattern->{append_value}) {
          $pattern->{append_type} = delete $pattern->{append_value};
        }
      } elsif (/[A-Z]/) {
        $pattern->{type} = 'rule';
        $pattern->{value} = $_;
      } else {
        $pattern->{type} = $_;
      }
      push @$patterns, $pattern;
    }

  } elsif (/\S/) {
    die "Broken line: $_";
  }
}

if (defined $patterns and not @$patterns) {
  die "Rule |$rule_name| has no definition";
}

print perl2json_bytes_for_record $Data;

## License: Public Domain.

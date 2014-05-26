package Web::IDL::Parser;
use strict;
use warnings;
our $VERSION = '1.0';
use Web::IDL::_Defs;

sub new ($) {
  return bless {}, $_[0];
} # new

sub onerror ($;$) {
  if (@_ > 1) {
    $_[0]->{onerror} = $_[1];
  }
  return $_[0]->{onerror} ||= sub {
    my %args = @_;
    warn sprintf "WebIDL parse error (%s): %s at index %d%s\n",
        $args{level},
        $args{type} . (defined $args{text} ? ': ' . $args{text} : ''),
        $args{index},
        (defined $args{value} ? ' "' . $args{value} . '"' : '');
  };
} # onerror

my $integer = qr/-?([1-9][0-9]*|0[Xx][0-9A-Fa-f]+|0[0-7]*)/;
my $float = qr/-?(([0-9]+\.[0-9]*|[0-9]*\.[0-9]+)([Ee][+-]?[0-9]+)?|[0-9]+[Ee][+-]?[0-9]+)/;
my $identifier = qr/_?[A-Za-z][0-9A-Z_a-z]*/;
my $string = qr/"[^"]*"/;
my $whitespace = qr/[\x09\x0A\x0D\x20]+/;
my $comment = qr{//.*|/\*(.|\x0A)*?\*/};
my $other = qr/[^\x09\x0A\x0D\x200-9A-Za-z]/;
my $token = qr/$float|$integer|$identifier|$string|\.\.\.|$whitespace|$comment|$other/;

sub _tokenize ($$) {
  my @result;
  while ($_[1] =~ /\G($token)/ogc) {
    my $t = $1;
    my $pos = $-[0];
    if ($t =~ /^$integer$/o) {
      push @result, {type => 'integer',
                     value => ($t =~ /^-?0/ ? hex $t : 0+$t),
                     index => $pos};
    } elsif ($t =~ /^$float$/o) {
      push @result, {type => 'float', value => 0+$t, index => $pos};
    } elsif ($t =~ /^$identifier$/o) {
      if ($Web::IDL::_Defs->{keyword_tokens}->{$t}) {
        push @result, {type => $t, index => $pos};
      } else {
        push @result, {type => 'identifier', value => $t, index => $pos};
      }
    } elsif ($t =~ /^$string$/o) {
      push @result, {type => 'string',
                     value => (substr $t, 1, -2 + length $t),
                     index => $pos};
    } elsif ($t =~ /^$whitespace$/o or
             $t =~ /^$comment$/o) {
      #
    } elsif ($t =~ /^$other$/o) {
      if ($Web::IDL::_Defs->{other_tokens}->{$t}) {
        push @result, {type => $t, index => $pos};
      } else {
        push @result, {type => 'other', value => $t, index => $pos};
      }
    } else {
      push @result, {type => $t, index => $pos};
    }
  }
  push @result, {type => 'EOF', index => length $_[1]};
  return \@result;
} # _tokenize

sub _match ($$$$) {
  my ($self, $input, $index, $pattern) = @_;

  my $input_i = $index;
  my $pattern_i = 0;

  my $returned = {};

  INPUT: while ($input_i < @$input) {
    if ($pattern_i > $#$pattern) {
      ## Pattern is shorter than input
      last INPUT;
    }

    my $p = $pattern->[$pattern_i];
    if ($p->{type} eq 'rule') {
      ## Non-terminal
      my $def = $Web::IDL::_Defs->{grammer}->{$p->{value}};
      if (defined $def) {
        my $second;
        MULTIPLE: {
          for my $rule (@{$def->{patterns}}) {
            my ($r, $new_index) = $self->_match ($input, $input_i, $rule);
            if (defined $r) {
              if ($def->{set_index}) {
                $r->{index} = $input->[$input_i]->{index}
                    if not defined $r->{index};
              }
              $input_i = $new_index;
              if (defined $p->{append}) {
                push @{$returned->{$p->{append}} ||= []}, $r;
              } elsif (defined $p->{set}) {
                $returned->{$p->{set}} = $r;
              } else {
                for (keys %$r) {
                  if (ref $r->{$_} eq 'ARRAY') {
                    push @{$returned->{$_} ||= []}, @{$r->{$_}};
                  } else {
                    $returned->{$_} = $r->{$_};
                  }
                }
              }
              if ($p->{multiple}) {
                $second = 1;
                redo MULTIPLE;
              } else {
                $pattern_i++;
                next INPUT;
              }
            }
          } # patterns
          if ($second) {
            $pattern_i++;
            next INPUT;
          }
        } # MULTIPLE
        if ($def->{can_be_empty} or $p->{multiple}) {
          if ($p->{multiple} and defined $p->{append}) {
            $returned->{$p->{append}} ||= [];
          }
          $pattern_i++;
          next INPUT;
        }
      }
      if ($input_i > $self->{max_index}) {
        $self->{max_index} = $input_i;
        $self->{last_pattern} = $pattern->[$pattern_i] || $self->{last_pattern};
      }
      return (undef, $index);
    } else {
      ## Terminal
      if ($input->[$input_i]->{type} eq $p->{type} and
          (not defined $p->{value} or
           $input->[$input_i]->{value} eq $p->{value})) {
        if ($input_i + 1 <= $#$input and
            defined $p->{next_is_not} and
            $p->{next_is_not}->{$input->[$input_i + 1]->{type}}) {
          #
        } else {
          ## Current token matched to current pattern
          if (defined $p->{set_value}) {
            $returned->{$p->{set_value}} = $input->[$input_i]->{value};
          }
          if (defined $p->{set_type}) {
            $returned->{$p->{set_type}} = $input->[$input_i]->{type};
          }
          if (defined $p->{set_true}) {
            $returned->{$p->{set_true}} = 1;
          }
          if (defined $p->{append_value}) {
            push @{$returned->{$p->{append_value}} ||= []},
                $input->[$input_i]->{value};
          }
          if (defined $p->{append_type}) {
            push @{$returned->{$p->{append_type}} ||= []},
                $input->[$input_i]->{type};
          }
          $input_i++;
          $pattern_i++;
          next INPUT;
        }
      } # Terminal matched
    } # Terminal or non-terminal

    ## Not matched
    if ($input_i > $self->{max_index}) {
      $self->{max_index} = $input_i;
      $self->{last_pattern} = $pattern->[$pattern_i] || $self->{last_pattern};
    }
    return (undef, $index);
  } # INPUT

  if ($pattern_i == @$pattern) {
    ## All tokens matched to all patterns, or pattern is shorter
    ## than input
    return ($returned, $input_i);
  }

  if ($input_i > $self->{max_index}) {
    $self->{max_index} = $input_i;
    $self->{last_pattern} = $pattern->[$pattern_i] || $self->{last_pattern};
  }
  return (undef, $index);
} # match

sub parse_char_string ($$) {
  my $self = $_[0];
  my $tokens = $self->_tokenize ($_[1]);

  $self->{max_index} = 0;
  delete $self->{last_pattern};
  my ($result, $index) = $self->_match
      ($tokens, 0,
       [{type => 'rule', value => 'Definitions'}, {type => 'EOF'}]);

  if ($index == @$tokens) {
    $self->{parsed_struct} = $result;
  } else {
    delete $self->{parsed_struct};
    my $index = ($tokens->[$self->{max_index}] || {index => 0})->{index};
    $self->onerror->(type => 'webidl:parse error',
                     text => join (', ', map { defined $_ ? $_ : '' }
                                   $self->{last_pattern}->{type},
                                   $self->{last_pattern}->{value}),
                     index => $index,
                     level => 'm');
  }
} # parse_char_string

sub parsed_struct ($) {
  return $_[0]->{parsed_struct};
} # parsed_struct

1;

=head1 LICENSE

Copyright 2014 Wakaba <wakaba@suikawiki.org>.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

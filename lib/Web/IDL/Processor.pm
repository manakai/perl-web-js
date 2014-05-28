package Web::IDL::Processor;
use strict;
use warnings;
our $VERSION = '1.0';

sub new ($) {
  return bless {defs => {}}, $_[0];
} # new

sub onerror ($;$) {
  if (@_ > 1) {
    $_[0]->{onerror} = $_[1];
  }
  return $_[0]->{onerror} ||= sub {
    my %args = @_;
    warn sprintf "WebIDL conformance error (%s): %s at index %d%s in document %d\n",
        $args{level},
        $args{type} . (defined $args{text} ? ': ' . $args{text} : ''),
        $args{index},
        (defined $args{value} ? ' "' . $args{value} . '"' : ''),
        $args{di};
  };
} # onerror

# XXX
## <http://heycam.github.io/webidl/#dfn-reserved-identifier>
my $ReservedIdentifiers = {
  constructor => 1, iterator => 1, toString => 1, toJSON => 1,
};
my $Reserved = {
  const => {prototype => 1},
  attribute => {prototype => 1},
  operation => {prototype => 1},
};

sub process_parsed_struct ($$$) {
  my ($self, $di, $in) = @_;
  for my $def (@{$in->{definitions} or []}) {
    if ($def->{definition_type} eq 'interface' or
        $def->{definition_type} eq 'class' or
        $def->{definition_type} eq 'exception' or
        $def->{definition_type} eq 'dictionary' or
        $def->{definition_type} eq 'callback' or
        $def->{definition_type} eq 'enum' or
        $def->{definition_type} eq 'typedef') {
      if (not $def->{partial} and $self->{state}->{has_def}->{$def->{name}}) {
        $self->onerror->(type => 'webidl:duplicate',
                         value => $def->{name},
                         di => $di,
                         index => $def->{index},
                         level => 'm');
      } else {
        if ($def->{partial}) {
          $self->{state}->{has_ref}->{$def->{name}} ||= [$di, $def->{index}];
        } else {
          if ($ReservedIdentifiers->{$def->{name}}) {
            $self->onerror->(type => 'webidl:reserved',
                             value => $def->{name},
                             di => $di,
                             index => $def->{index},
                             level => 'm');
          }
          $self->{state}->{has_def}->{$def->{name}} = $def->{definition_type};
        }

        if ($def->{partial}) {
          $self->{defs}->{$def->{name}}->[0] ||= $def->{definition_type};
        } elsif ($def->{definition_type} eq 'interface' and $def->{callback}) {
          $self->{defs}->{$def->{name}}->[0] = 'callback interface';
        } else {
          $self->{defs}->{$def->{name}}->[0] = $def->{definition_type};
        }
        my $props = $self->{defs}->{$def->{name}}->[1] ||= {};

        # XXX inherited inteface; inheritance hierarchy MUST NOT have a circle
        # XXX callback interface MUST NOT inherit from non-callback interface
        # XXX non-callback interface MUST NOT inherit from callback interface
        # XXX callback interface MUST NOT have consequential interface

        if ($def->{definition_type} eq 'typedef') {
          $props->{type} = $self->_type ($di, $def);
        }

        if ($def->{definition_type} eq 'callback') {
          $props->{overloadSet} = $self->_overload_set ($di, [$def]);
        }

        if ($def->{definition_type} eq 'enum') {
          $props->{values} ||= {};
          for (@{$def->{value_strings}}) {
            if (defined $props->{values}->{$_}) {
              $self->onerror->(type => 'webidl:duplicate',
                               value => $_,
                               di => $di,
                               index => $def->{index},
                               level => 'm');
            } else {
              $props->{values}->{$_} = 1;
            }
          }
        } # enum

        if ($def->{definition_type} eq 'interface' or
            $def->{definition_type} eq 'class' or
            $def->{definition_type} eq 'exception' or
            $def->{definition_type} eq 'dictionary') {
          my @mem = grep {
            not $_->{member_type} eq 'operation';
          } @{$def->{members} or []};

          my %op;
          for my $mem (@{$def->{members} or []}) {
            next unless $mem->{member_type} eq 'operation';
            if (not defined $mem->{name}) {
              # XXX
              
              # XXX If no special keyword
              $self->onerror->(type => 'webidl:no name operation',
                               di => $di,
                               index => $mem->{index},
                               level => 'm');
            } else {
              if (@{$op{$mem->{name}} ||= []}) {
                if ($mem->{static} and not $op{$mem->{name}}->[0]->{static} or
                    not $mem->{static} and $op{$mem->{name}}->[0]->{static}) {
                  $self->onerror->(type => 'webidl:duplicate',
                                   di => $di,
                                   index => $mem->{index},
                                   value => $mem->{name},
                                   level => 'm');
                  next;
                }
              }
              push @{$op{$mem->{name}} ||= []}, $mem;
            }
          } # $mem

          for my $op_name (keys %op) {
            push @mem,
                {member_type => 'operation',
                 static => $op{$op_name}->[0]->{static},
                 name => $op_name,
                 index => $op{$op_name}->[0]->{index},
                 overloadSet => $self->_overload_set ($di, $op{$op_name})};
          } # %op

          $props->{members} ||= {};
          for my $mem (@mem) {
            if (not defined $mem->{name}) {
              # XXX

            } elsif ($mem->{member_type} eq 'operation') {
              if (defined $props->{members}->{$mem->{name}}) {
                $self->onerror->(type => 'webidl:duplicate',
                                 value => $mem->{name},
                                 di => $di,
                                 index => $mem->{index},
                                 level => 'm');
              } else {
                if ($ReservedIdentifiers->{$mem->{name}} or
                    $Reserved->{$mem->{member_type}}->{$mem->{name}}) {
                  $self->onerror->(type => 'webidl:reserved',
                                   value => $mem->{name},
                                   di => $di,
                                   index => $mem->{index},
                                   level => 'm');
                }

                if ($mem->{member_type} eq 'operation' and $mem->{static}) {
                  $props->{members}->{$mem->{name}}->[0] = 'static operation';
                } else {
                  $props->{members}->{$mem->{name}}->[0] = $mem->{member_type};
                }
                my $mem_props = $props->{members}->{$mem->{name}}->[1] ||= {};

                $mem_props->{overloadSet} = $mem->{overloadSet};
              }
            } elsif ($mem->{member_type} eq 'const' or
                     $mem->{member_type} eq 'attribute' or
                     $mem->{member_type} eq 'field' or
                     $mem->{member_type} eq 'dictionary_member') {
              if (defined $props->{members}->{$mem->{name}}) {
                $self->onerror->(type => 'webidl:duplicate',
                                 value => $mem->{name},
                                 di => $di,
                                 index => $mem->{index},
                                 level => 'm');
              } else {
                if ($ReservedIdentifiers->{$mem->{name}} or
                    $Reserved->{$mem->{member_type}}->{$mem->{name}}) {
                  $self->onerror->(type => 'webidl:reserved',
                                   value => $mem->{name},
                                   di => $di,
                                   index => $mem->{index},
                                   level => 'm');
                }

                if ($mem->{member_type} eq 'attribute' and $mem->{static}) {
                  $props->{members}->{$mem->{name}}->[0] = 'static attribute';
                } else {
                  $props->{members}->{$mem->{name}}->[0] = $mem->{member_type};
                }
                my $mem_props = $props->{members}->{$mem->{name}}->[1] ||= {};

                # XXX stringifier

                $mem_props->{type} = $self->_type ($di, $mem);
                # XXX const: type check
                # XXX attribute: type check

                if ($mem->{member_type} eq 'attribute') {
                  if ($mem->{readonly}) {
                    if ($mem->{inherit}) {
                      $self->onerror->(type => 'webidl:not allowed',
                                       di => $di,
                                       index => $mem->{index},
                                       value => 'inherit',
                                       level => 'm');
                    }
                    $mem_props->{getter} = 1;
                  } elsif ($mem->{inherit}) {
                    if ($mem->{static}) {
                      $self->onerror->(type => 'webidl:not allowed',
                                       di => $di,
                                       index => $mem->{index},
                                       value => 'inherit',
                                       level => 'm');
                    }
                    $mem_props->{setter} = 1;
                    # XXX inherited MUST be of the same type
                  } else {
                    $mem_props->{getter} = 1;
                    $mem_props->{setter} = 1;
                  }
                }

                if ($mem->{member_type} eq 'const' or
                    $mem->{member_type} eq 'dictionary_member') {
                  $mem_props->{value} = $self->_value
                      ($di, $mem,
                       optional => $mem->{member_type} eq 'dictionary_member');
                  delete $mem_props->{value} unless defined $mem_props->{value};
                  # XXX integer MUST be in the range
                  # XXX float MUST be in the range
                  # XXX float value or literal MUST be in range
                  # XXX value type MUST be compat with type
                }
              }
            }

            # XXX extended attributes
          }
        } # has member

        # XXX extended attributes

        # XXX SHOULD NOT define new callback interface with only a
        # single operation
      }
    } elsif ($def->{definition_type} eq 'implements') {
      # XXX

    } else {
      $self->onerror->(type => 'webidl:unknown definition',
                       value => $def->{definition_type},
                       level => 'u');
    }
  }
} # process_parsed_struct

sub _type ($$$) {
  my ($self, $di, $def) = @_;
  my $value;
  if (defined $def->{type}) {
    $value = $def->{type};
  } elsif (defined $def->{type_name}) {
    $self->{state}->{has_ref}->{$def->{type_name}} ||= [$di, $def->{index}];
    $value = ['ref', $def->{type_name}];
  } elsif (defined $def->{type_parameterized}) {
    $value = [$def->{type_parameterized}->{type_outer},
              $self->_type ($di, {index => $def->{index},
                                  %{$def->{type_parameterized}}})];
  } else {
    $self->onerror->(type => 'webidl:unknown type',
                     di => $di,
                     index => $def->{index},
                     level => 'u');
    $value = 'any';
  }

  NEST: {
    if ($def->{type_nullable}) {
      $value = ['nullable', $value];
    }

    if (defined $def->{type_array}) {
      $def = {index => $def->{index}, %{$def->{type_array}}};
      $value = ['array', $value];
      redo NEST;
    }
  } # NEST

  return $value;
} # _type

sub _serialize_type ($$) {
  my ($self, $type) = @_;
  if (ref $type) {
    return $type->[0] . '[' . $type->[1] . ']';
  } else {
    return $type;
  }
} # _serialize_type

sub _value ($$$;%) {
  my ($self, $di, $obj, %args) = @_;
  if (defined $obj->{value_integer}) {
    return ['integer', $obj->{value_integer}];
  } elsif (defined $obj->{value_float}) {
    return ['float', $obj->{value_float}];
  } elsif (defined $obj->{value_string}) {
    return ['string', $obj->{value_string}];
  } elsif (defined $obj->{value}) {
    return $obj->{value};
  } elsif ($args{optional}) {
    return undef;
  } else {
    $self->onerror->(type => 'webidl:unknown value',
                     di => $di,
                     index => $obj->{index},
                     level => 'u');
    return 'null';
  }
} # _value

## <http://heycam.github.io/webidl/#dfn-effective-overload-set> but m
## := n
sub _overload_set ($$$) {
  ## 2.
  my ($self, $di, $F) = @_;

  ## 1.
  my $S = [];

  ## 3.
  my $maxarg = 0;
  for (@$F) {
    my $n = @{$_->{arguments} or []};
    $maxarg = $n if $n > $maxarg;
  }

  ## 4.
  #my $m = $maxarg > $N ? $maxarg : $N;
  my $m = $maxarg;

  ## 5.
  for (@$F) {
    ## 5.1.
    my $n = @{$_->{arguments} or []};

    my $args = [];
    my %name;
    for my $i (0..($n-1)) {
      ## 5.2.
      $args->[$i]->{type} = $self->_type ($di, $_->{arguments}->[$i]);
      $args->[$i]->{type_serialized} = $self->_serialize_type
          ($args->[$i]->{type});
      # XXX type restrictions

      my $name = $args->[$i]->{name} = $_->{arguments}->[$i]->{name};
      if ($ReservedIdentifiers->{$name}) {
        $self->onerror->(type => 'webidl:reserved',
                         value => $name,
                         di => $di,
                         index => $_->{index},
                         level => 'm');
      }
      if ($name{$name}) {
        $self->onerror->(type => 'webidl:duplicate',
                         value => $name,
                         di => $di,
                         index => $_->{index},
                         level => 'm');
      } else {
        $name{$name} = 1;
      }

      ## 5.3.
      if ($_->{arguments}->[$i]->{variadic}) {
        if ($i == $n - 1) {
          $args->[$i]->{optionality} = 'variadic';
        } else {
          $self->onerror->(type => 'webidl:bad optionality',
                           di => $di,
                           index => $_->{arguments}->[$i]->{index},
                           value => $name,
                           level => 'm');
          $args->[$i]->{optionality} = 'required';
        }
      } else {
        $args->[$i]->{optionality} = $_->{arguments}->[$i]->{optional} ? 'optional' : 'required';
      }

      $args->[$i]->{value} = $self->_value
          ($di, $_->{arguments}->[$i], optional => 1);
      delete $args->[$i]->{value} unless defined $args->[$i]->{value};
      # XXX integer value MUST be in range
      # XXX float value or literal MUST be in range
      # XXX value type MUST be compat with type
      # XXX if type is enumeration, value MUST be one of them

      # XXX If dictionary type and ...

      # XXX extended attributes
    }

    my $type = $self->_type ($di, $_);
    # XXX type restrictions

    ## 5.4.
    push @$S, {type => $type, args => $args,
               index => $_->{index}};

    ## 5.6.
    my $l = $n - 1;

    ## 5.5.
    if (@$args and $args->[-1]->{optionality} eq 'variadic') {
      ## 5.5.1.
      push @$S, {type => $type, args => [@$args[0..($#$args-1)]],
                 index => $_->{index}};
      
      ## 5.5.2.
      # N/A

      $l--;
    }

    ## 5.7.
    while ($l >= 0) {
      ## 5.7.1.
      last unless $args->[$l]->{optionality} eq 'optional';

      ## 5.7.2.
      push @$S, {type => $type, args => [@$args[0..($l-1)]],
                 index => $_->{index}};

      ## 5.7.3.
      $l--;
    }

    ## 5.8.
    if (@$args and $l == 0 and $args->[0]->{optionality} eq 'optional') {
      push @$S, {type => $type, args => [], index => $_->{index}};
    }
  }

  my %S;
  for (@$S) {
    my $key = join ',', map { $_->{type_serialized} } @{$_->{args}};
    if (defined $S{$key}) {
      $self->onerror->(type => 'webidl:not distinguishable',
                       value => $key,
                       di => $di,
                       index => $_->{index},
                       level => 'm');
    } else {
      # XXX More distinguishability check
      $S{$key} = $_;

      delete $_->{index};
    }
  } # @$S

  for (values %S) {
    delete $_->{index}, delete $_->{type_serialized} for @{$_->{args}};
  }
  return \%S;
} # _overload_set

sub end_processing ($) {
  my $self = $_[0];
  for my $name (keys %{$self->{state}->{has_ref} or {}}) {
    next if $self->{state}->{has_def}->{$name};
    $self->onerror->(type => 'webidl:not defined',
                     value => $name,
                     di => $self->{state}->{has_ref}->{$name}->[0],
                     index => $self->{state}->{has_ref}->{$name}->[1],
                     level => 'm');
    # XXX type mismatch check
  }
} # end_processing

sub definitions ($) {
  return $_[0]->{defs};
} # definitions

1;

=head1 LICENSE

Copyright 2014 Wakaba <wakaba@suikawiki.org>.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

package Web::IDL::Processor;
use strict;
use warnings;
no warnings 'utf8';
use warnings FATAL => 'recursion';
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
  exception => {Error => 1, EvalError => 1, RangeError => 1,
                ReferenceError => 1, SyntaxError => 1, TypeError => 1,
                URIError => 1},
  field => {name => 1, message => 1},
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
          if ($ReservedIdentifiers->{$def->{name}} or
              $Reserved->{$def->{definition_type}}->{$def->{name}}) {
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
          $self->{defs}->{$def->{name}}->[0] = 'callback_interface';
        } else {
          $self->{defs}->{$def->{name}}->[0] = $def->{definition_type};
        }
        my $props = $self->{defs}->{$def->{name}}->[1] ||= {};

        # XXX exception SHOULD NOT be used

        # XXX partial interface: it MUST be interface
        # XXX partial dictionary: it MUST be dictionary

        ## Inheritance
        if ($def->{definition_type} eq 'interface' or
            $def->{definition_type} eq 'class' or
            $def->{definition_type} eq 'exception') {
          if (defined $def->{super_name}) {
            push @{$self->{state}->{inherits} ||= []},
                [$def->{name} => $def->{super_name}, $di, $def->{index}];
          }
        }

        # XXX inherited dictionary; inheritance hierarchy MUST NOT have a circle

        # XXX callback interface MUST NOT have consequential interface
        # XXX warn if an object implements multiple interfaces with a special operation

        # XXX If there is named*, there MUST be namedGetter
        # XXX If there is indexed*, there MUST be indexedGetter
        # XXX no special operation on callback interface
        # XXX MUST NOT use "next" as an interface member on iterator object interface or its consequential interface
        # XXX no duplicate iterator amongst consequential interfaces
        # XXX no duplicate iterator object amongst consequential interfaces
        # XXX inherited dictionary's member's name MUST NOT be used
        # XXX there MUST NOT be identifier conflicting member on consequential interfaces

        if ($def->{definition_type} eq 'typedef') {
          $props->{type} = $self->_type ($di, $def);
          # XXX MUST NOT use itself directly or indirectly
        }

        if ($def->{definition_type} eq 'callback') {
          $props->{overload_set} = $self->_overload_set ($di, [$def]);
        }

        if ($def->{definition_type} eq 'enum') {
          my $vals = {};
          for (@{$def->{value_strings}}) {
            if (defined $vals->{$_}) {
              $self->onerror->(type => 'webidl:duplicate',
                               value => $_,
                               di => $di,
                               index => $def->{index},
                               level => 'm');
            } else {
              $vals->{$_} = 1;
            }
          }
          $props->{value} = ['stringset', $vals];
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
            my @key;
            push @key, 'legacycaller' if $mem->{legacycaller};
            push @key, 'stringifier' if $mem->{stringifier};
            push @key, 'serializer' if $mem->{serializer};
            if ($mem->{getter} or $mem->{setter} or
                $mem->{creator} or $mem->{deleter}) {
              if (@{$mem->{arguments} or []} and
                  defined $mem->{arguments}->[0]->{type}) {
                if ($mem->{arguments}->[0]->{type} eq 'unsigned long' and
                    not $mem->{arguments}->[0]->{type_nullable} and
                    not defined $mem->{arguments}->[0]->{type_array}) {
                  push @key, 'indexed_getter' if $mem->{getter};
                  push @key, 'indexed_setter' if $mem->{setter};
                  push @key, 'indexed_creator' if $mem->{creator};
                  push @key, 'indexed_deleter' if $mem->{deleter};
                } elsif ($mem->{arguments}->[0]->{type} eq 'DOMString' and
                         not $mem->{arguments}->[0]->{type_nullable} and
                         not defined $mem->{arguments}->[0]->{type_array}) {
                  push @key, 'named_getter' if $mem->{getter};
                  push @key, 'named_setter' if $mem->{setter};
                  push @key, 'named_creator' if $mem->{creator};
                  push @key, 'named_deleter' if $mem->{deleter};
                } else {
                  $self->onerror->(type => 'webidl:bad args',
                                   di => $di,
                                   index => $mem->{index},
                                   value => $mem->{name},
                                   level => 'm');
                }
              } else {
                $self->onerror->(type => 'webidl:bad args',
                                 di => $di,
                                 index => $mem->{index},
                                 value => $mem->{name},
                                 level => 'm');
              }
            }
            push @key, $; . $mem->{name} if defined $mem->{name};
            unless (@key) {
              $self->onerror->(type => 'webidl:no name operation',
                               di => $di,
                               index => $mem->{index},
                               level => 'm');
              next;
            }

            for my $key (@key) {
              if (@{$op{$key} ||= []}) {
                if ($mem->{static} and not $op{$key}->[0]->{static} or
                    not $mem->{static} and $op{$key}->[0]->{static}) {
                  $self->onerror->(type => 'webidl:duplicate',
                                   di => $di,
                                   index => $mem->{index},
                                   value => $mem->{name},
                                   level => 'm');
                  next;
                }
              }
              push @{$op{$key} ||= []}, $mem;
            } # $key
          } # $mem

          for my $key (keys %op) {
            my $mem = {member_type => 'operation',
                       static => $op{$key}->[0]->{static},
                       special => ($key =~ /$;/o ? undef : $key),
                       name => $op{$key}->[0]->{name},
                       index => $op{$key}->[0]->{index}};
            $mem->{overload_set} = $self->_overload_set
                ($di, $op{$key}, special => $mem->{special});
            push @mem, $mem;
          } # %op

          $props->{members} ||= {};
          for my $mem (@mem) {
            if ($mem->{member_type} eq 'operation') {
              if (defined $mem->{special}) { ## Special operation
                if (defined $props->{$mem->{special}}) {
                  $self->onerror->(type => 'webidl:duplicate',
                                   value => $mem->{special},
                                   di => $di,
                                   index => $mem->{index},
                                   level => 'm');
                } else {
                  $props->{$mem->{special}}->[0] = $mem->{member_type};
                  my $mem_props = $props->{$mem->{special}}->[1] ||= {};
                  $mem_props->{overload_set} = $mem->{overload_set};

                  if ($mem->{special} eq 'legacycaller') {
                    # XXX legacycaller SHOULD NOT be used
                    
                  }
                }
              } else { ## Regular or static operation
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
                    $props->{members}->{$mem->{name}}->[0] = 'static_operation';
                    if ($self->{defs}->{$def->{name}}->[0] eq 'callback_interface') {
                      $self->onerror->(type => 'webidl:not allowed',
                                       value => $mem->{name},
                                       di => $di,
                                       index => $mem->{index},
                                       level => 'm');
                    }
                  } else {
                    $props->{members}->{$mem->{name}}->[0] = $mem->{member_type};
                  }
                  my $mem_props = $props->{members}->{$mem->{name}}->[1] ||= {};

                  $mem_props->{overload_set} = $mem->{overload_set};
                }
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
                  $props->{members}->{$mem->{name}}->[0] = 'static_attribute';
                  if ($self->{defs}->{$def->{name}}->[0] eq 'callback_interface') {
                    $self->onerror->(type => 'webidl:not allowed',
                                     value => $mem->{name},
                                     di => $di,
                                     index => $mem->{index},
                                     level => 'm');
                  }
                } else {
                  $props->{members}->{$mem->{name}}->[0] = $mem->{member_type};
                }
                my $mem_props = $props->{members}->{$mem->{name}}->[1] ||= {};

                # XXX const SHOULD NOT be used

                $mem_props->{type} = $self->_type ($di, $mem);
                # XXX const: type check; MUST NOT use dictionary; MUST NOT use callback function; MUST NOT use sequence
                # XXX attribute: type check; MUST NOT use dictionary; MUST NOT use sequence
                # XXX dictionary member: type check
                # XXX exception field: type check; MUST NOT use dictionary; MUST NOT use sequence

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

                  if ($mem->{stringifier}) {
                    if (defined $props->{stringifier}) {
                      $self->onerror->(type => 'webidl:duplicate',
                                       value => 'stringifier',
                                       di => $di,
                                       index => $mem->{index},
                                       level => 'm');
                    } else {
                      if (not ref $mem_props->{type} and
                          $mem_props->{type} eq 'DOMString') {
                        #
                      } else {
                        $self->onerror->(type => 'webidl:bad type',
                                         value => 'stringifier',
                                         di => $di,
                                         index => $mem->{index},
                                         level => 'm');
                      }
                      $props->{stringifier} = ['attrref', $mem->{name}];
                    }
                  }
                } # attribute

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
                  # XXX string MUST be one of enum
                } # has value
              }
            } elsif ($mem->{member_type} eq 'serializer') {
              if (defined $props->{serializer}) {
                $self->onerror->(type => 'webidl:duplicate',
                                 value => 'serializer',
                                 di => $di,
                                 index => $mem->{index},
                                 level => 'm');
              } else {
                $props->{serializer}->[0] = $mem->{member_type};
                my $mem_props = $props->{serializer}->[1] ||= {};
                
                $mem_props->{value} = $self->_value
                    ($di, $mem, optional => 1, context => 'serializer');
                delete $mem_props->{value} unless defined $mem_props->{value};
              }
            } elsif ($mem->{member_type} eq 'iterator') {
              if (defined $props->{iterator}) {
                $self->onerror->(type => 'webidl:duplicate',
                                 value => 'iterator',
                                 di => $di,
                                 index => $mem->{index},
                                 level => 'm');
              } else {
                $props->{iterator}->[0] = $mem->{member_type};
                my $mem_props = $props->{iterator}->[1] ||= {};

                $mem_props->{type} = $self->_type ($di, $mem);
                
                $mem_props->{value} = $self->_value
                    ($di, $mem, optional => 1, context => 'iterator');
                delete $mem_props->{value} unless defined $mem_props->{value};

                # XXX if {value} is not undef, its "iterator object"'s
                # return type MUST be $self->{type}.
              }
            } elsif ($mem->{member_type} eq 'iterator_object') {
              if (defined $props->{iterator_object}) {
                $self->onerror->(type => 'webidl:duplicate',
                                 value => 'iterator object',
                                 di => $di,
                                 index => $mem->{index},
                                 level => 'm');
              } else {
                $props->{iterator_object}->[0] = $mem->{member_type};
                my $mem_props = $props->{iterator_object}->[1] ||= {};

                $mem_props->{type} = $self->_type ($di, $mem);
              }
            } else {
              $self->onerror->(type => 'webidl:unknown',
                               value => $mem->{member_type},
                               level => 'u');
            } # member_type

            # XXX extended attributes
          }
        } # has member

        # XXX extended attributes

        # XXX SHOULD NOT define new callback interface with only a
        # single operation
      }
    } elsif ($def->{definition_type} eq 'implements') {
      # XXX left MUST be interface; MUST NOT be callback interface
      # XXX right MUST be interface; MUST NOT be callback interface
      # XXX left != right, directly or by inheritance
      # XXX MUST NOT have circle
      # XXX supplemental interface is discouraged to implements another

    } else {
      $self->onerror->(type => 'webidl:unknown',
                       value => $def->{definition_type},
                       level => 'u');
    }
  } # definitions
} # process_parsed_struct

sub _type ($$$) {
  my ($self, $di, $def) = @_;
  my $value;
  if (defined $def->{type}) {
    # XXX warn if float
    # XXX SHOULD NOT use ByteString
    $value = $def->{type};
  } elsif (defined $def->{type_name}) {
    $self->{state}->{has_ref}->{$def->{type_name}} ||= [$di, $def->{index}];
    $value = ['ref', $def->{type_name}];
  } elsif (defined $def->{type_parameterized}) {
    $value = [$def->{type_parameterized}->{type_outer},
              $self->_type ($di, {index => $def->{index},
                                  %{$def->{type_parameterized}}})];
  } elsif (defined $def->{type_union}) {
    $value = ['union', map { $self->_type ($di, $_) } @{$def->{type_union}}];
    # XXX MUST be at most one nullable member type
    # XXX If a nullable member, MUST NOT be dictionary type in flattened member
    # XXX flattened member types MUST be distinguishable
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
      # XXX check $value
    }

    if (defined $def->{type_array}) {
      $def = {index => $def->{index}, %{$def->{type_array}}};
      $value = ['array', $value];
      # XXX MUST NOT use sequence or dictionary
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
  } elsif (defined $obj->{value_name} and
           defined $args{context} and $args{context} eq 'serializer') {
    return ['attrref', $obj->{value_name}];
    # XXX MUST be an attribute of serializable type
  } elsif (defined $obj->{value_name} and
           defined $args{context} and $args{context} eq 'iterator') {
    return ['interfaceref', $obj->{value_name}];
    # XXX MUST be an iterator object interface
  } elsif (defined $obj->{value}) {
    return $obj->{value};
  } elsif (defined $obj->{value_map} or defined $obj->{value_list}) {
    my $o = $obj->{value_map} || $obj->{value_list};
    my @v = defined $obj->{value_map} ? 'map' : 'list';
    push @v, 'inherit' if $o->{inherit};
    # XXX restriction on usage of "inherit"
    push @v, 'attribute' if $o->{attribute};
    # XXX expand attribute and inherit
    push @v, 'getter' if $o->{getter};
    # XXX requires indexed/named properties and whose type is serializable
    if (defined $o) {
      # XXX MUST be attributes whose type is serializable
      push @v, map { ['attrref', $_] } @{$o->{value_names}};
    }
    return \@v;
  } elsif ($args{optional}) {
    return undef;
  }
  $self->onerror->(type => 'webidl:unknown value',
                   di => $di,
                   index => $obj->{index},
                   level => 'u');
  return 'null';
} # _value

## <http://heycam.github.io/webidl/#dfn-effective-overload-set> but m
## := n
sub _overload_set ($$$;%) {
  ## 2.
  my ($self, $di, $F, %args) = @_;

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
      if (defined $args{special} and
          not $args->[$i]->{optionality} eq 'required') {
        $self->onerror->(type => 'webidl:bad optionality',
                         di => $di,
                         index => $_->{arguments}->[$i]->{index},
                         value => $name,
                         level => 'm');
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
    my $expected_length;
    if (not defined $args{special}) {
      #
    } elsif ($args{special} eq 'legacycaller') {
      if ((not ref $type and $type eq 'Promise') or
          (ref $type eq 'ARRAY' and $type->[0] eq 'Promise')) {
        ## XXX union, nullable, sequence, array of Promise should also
        ## be disallowed?
        $self->onerror->(type => 'webidl:bad type',
                         di => $di,
                         index => $_->{index},
                         value => $self->_serialize_type ($type),
                         level => 'm');
      }
    } elsif ($args{special} eq 'stringifier') {
      if (not ref $type and $type eq 'DOMString') {
        #
      } else {
        $self->onerror->(type => 'webidl:bad type',
                         di => $di,
                         index => $_->{index},
                         value => $self->_serialize_type ($type),
                         level => 'm');
      }
      $expected_length = 0;
    } elsif ($args{special} eq 'serializer') {
      # XXX MUST be serializable type
      $expected_length = 0;
    } elsif ($args{special} eq 'getter' or
             $args{special} eq 'deleter') {
      $expected_length = 1;
    } elsif ($args{special} eq 'setter' or
             $args{special} eq 'creator') {
      $expected_length = 2;
    } # $args{special}
    if (defined $expected_length and not $n == $expected_length) {
      $self->onerror->(type => 'webidl:bad args',
                       di => $di,
                       index => $_->{index},
                       value => $args{special},
                       level => 'm');
    }

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
      # XXX args whose index less than distinguishing argument index MUST have same types and same optionality
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

  ## Resolve inheritance
  for (@{$self->{state}->{inherits} || []}) {
    my ($sub, $super, $di, $index) = @$_;
    my $sub_def = $self->{defs}->{$sub} or die;
    my $super_def = $self->{defs}->{$super};

    if (not defined $super_def) {
      $self->onerror->(type => 'webidl:not defined',
                       di => $di,
                       index => $index,
                       value => $super,
                       level => 'm');
    } elsif (not $sub_def->[0] eq $super_def->[0]) {
      $self->onerror->(type => 'webidl:bad type',
                       di => $di,
                       index => $index,
                       value => $super,
                       level => 'm');
    } elsif (($super_def->[1]->{implements} or {})->{$sub} or
             $sub eq $super) {
      $self->onerror->(type => 'webidl:cyclic inheritance',
                       di => $di,
                       index => $index,
                       value => $super,
                       level => 'm');
    } else {
      $sub_def->[1]->{implements}->{$super}->{depth} = 1;
      for (keys %{$super_def->[1]->{implements} or {}}) {
        $sub_def->[1]->{implements}->{$_}->{depth}
            = 1 + $super_def->[1]->{implements}->{$_}->{depth};
      }

      for my $n (keys %{$self->{defs}}) {
        my $n_def = $self->{defs}->{$n};
        if (($n_def->[1]->{implements} or {})->{$sub}) {
          die unless $n_def->[0] eq $sub_def->[0];
          for (keys %{$sub_def->[1]->{implements} or {}}) {
            $n_def->[1]->{implements}->{$_}->{depth}
                = $n_def->[1]->{implements}->{$sub}->{depth}
                + $sub_def->[1]->{implements}->{$_}->{depth};
          }
        }
      }
    }
  } # inherits
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

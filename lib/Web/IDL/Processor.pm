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
          $self->{state}->{has_ref}->{$def->{name}}
              ||= [['ref', $def->{name}], $di, $def->{index}];
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
          if (not defined $self->{defs}->{$def->{name}}->[0] or
              $self->{defs}->{$def->{name}}->[0] eq $def->{definition_type} or
              ($self->{defs}->{$def->{name}}->[0] eq 'callback_interface' and
               $def->{definition_type} eq 'interface')) {
            #
          } else {
            $self->onerror->(type => 'webidl:bad type',
                             di => $di,
                             index => $def->{index},
                             value => $def->{definition_type},
                             level => 'm');
            next;
          }
          $self->{defs}->{$def->{name}}->[0] ||= $def->{definition_type};
        } elsif ($def->{definition_type} eq 'interface' and $def->{callback}) {
          $self->{defs}->{$def->{name}}->[0] = 'callback_interface';
        } else {
          if (not defined $self->{defs}->{$def->{name}}->[0] or
              $self->{defs}->{$def->{name}}->[0] eq $def->{definition_type} or
              ($self->{defs}->{$def->{name}}->[0] eq 'interface' and
               $def->{definition_type} eq 'callback_interface')) {
            #
          } else {
            $self->onerror->(type => 'webidl:bad type',
                             di => $di,
                             index => $def->{index},
                             value => $def->{definition_type},
                             level => 'm');
            $self->{defs}->{$def->{name}}->[1] = {};
          }
          $self->{defs}->{$def->{name}}->[0] = $def->{definition_type};
        }
        my $props = $self->{defs}->{$def->{name}}->[1] ||= {};

        # XXX exception SHOULD NOT be used

        ## Inheritance
        if ($def->{definition_type} eq 'interface' or
            $def->{definition_type} eq 'class' or
            $def->{definition_type} eq 'exception' or
            $def->{definition_type} eq 'dictionary') {
          if (defined $def->{super_name}) {
            push @{$self->{state}->{inherits} ||= []},
                [$def->{name} => $def->{super_name}, $di, $def->{index}];
          }
        }

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

                  $self->_extended_attributes ($di, $mem => $mem_props);
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
                  $self->_extended_attributes ($di, $mem => $mem_props);
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
                    $mem_props->{getter} = 'inherit';
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

                $self->_extended_attributes ($di, $mem => $mem_props);
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
                $self->_extended_attributes ($di, $mem => $mem_props);
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

                $self->_extended_attributes ($di, $mem => $mem_props);
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
                $self->_extended_attributes ($di, $mem => $mem_props);
              }
            } else {
              $self->onerror->(type => 'webidl:unknown',
                               value => $mem->{member_type},
                               level => 'u');
            } # member_type
          }
        } # has member

        $self->_extended_attributes ($di, $def => $props);

        # XXX SHOULD NOT define new callback interface with only a
        # single operation
      }
    } elsif ($def->{definition_type} eq 'implements') {
      push @{$self->{state}->{implements} ||= []},
          [$def->{name} => $def->{super_name}, $di, $def->{index}];
      $self->_extended_attributes ($di, $def => {});
    } else {
      $self->onerror->(type => 'webidl:unknown',
                       value => $def->{definition_type},
                       level => 'u');
    }
  } # definitions
} # process_parsed_struct

# XXX
my $XAttrAllowed = {
  interface => {
    ArrayClass => 1, Constructor => 1, Exposed => 1, Global => 1,
    ImplicitThis => 1, MapClass => 1, NamedConstructor => 1,
    NoInterfaceObject => 1, OverrideBuiltins => 1, PrimaryGlobal => 1,
    Unforgeable => 1,
  },
  callback_interface => {
    ArrayClass => 1, Exposed => 1, Global => 1,
    ImplicitThis => 1, MapClass => 1, NamedConstructor => 1,
    NoInterfaceObject => 1, OverrideBuiltins => 1, PrimaryGlobal => 1,
    Unforgeable => 1,
  },
  partial_interface => {
    Exposed => 1, Global => 1, OverrideBuiltins => 1,
    PrimaryGlobal => 1, Unforgeable => 1,
  },
  const => {
    Exposed => 1,
  },
  attribute => {
    Clamp => 1, EnforceRange => 1, EnsureUTF16 => 1, Exposed => 1,
    SameObject => 1, TreatNullAs => 1,
    LenientThis => 1, PutForwards => 1, Replaceable => 1,
    Unforgeable => 1,
  },
  static_attribute => {
    Clamp => 1, EnforceRange => 1, EnsureUTF16 => 1, Exposed => 1,
    SameObject => 1, TreatNullAs => 1,
  },
  operation => {
    Exposed => 1, NewObject => 1, TreatNullAs => 1, Unforgeable => 1,
  },
  static_operation => {
    Exposed => 1, NewObject => 1, TreatNullAs => 1, Unforgeable => 1,
  },
  argument => {
    Clamp => 1, EnforceRange => 1, EnsureUTF1 => 1, TreatNullAs => 1,
  },
  serializer => {},
  iterator => {
    Exposed => 1,
  },
  iterator_object => {},
  dictionary => {
    Constructor => 1, Exposed => 1,
  },
  partial_dictionary => {},
  dictionary_member => {
    Clamp => 1, EnforceRange => 1,
  },
  exception => {
    NoInterfaceObject => 1,
  },
  field => {},
  enum => {},
  callback_function => {
    TreatNonObjectAsNull => 1,
  },
  typedef => {},
  implements => {},
};

my $XAttrArgs = {
  ArrayClass => {no => 1},
  Clamp => {no => 1},
  Constructor => {no => 1, args => 1},
  MapClass => {no => 1},
};

my $XAttrMultiple = {
  Constructor => 1,
};

my $XAttrDisallowedCombinations = [
  ['ArrayClass', 'MapClass'],
  ['Clamp', 'EnforceRange'],
  ['Constructor', 'NoInterfaceObject'],
];

sub _extended_attributes ($$$$) {
  my ($self, $di, $src, $dest) = @_;
  my $has_xattrs = {};
  my @constructor;
  for my $attr (@{$src->{extended_attributes} or []}) {
    my $context = $src->{definition_type} || $src->{member_type} || 'argument';
    $context = 'partial_' . $context if $src->{partial};
    $context = 'static_' . $context if $src->{context};
    $context = 'callback_' . $context if $src->{callback};
    if ($XAttrAllowed->{$context}->{$attr->{name}}) {
      if ($has_xattrs->{$attr->{name}}) {
        unless ($XAttrMultiple->{$attr->{name}}) {
          $self->onerror->(type => 'webidl:not allowed',
                           value => $attr->{name},
                           di => $di,
                           index => $attr->{index},
                           level => 'm');
          next;
        }
      } else {
        $has_xattrs->{$attr->{name}} = 1;
      }

      my $args_type = 'no';
      if (defined $attr->{arguments}) {
        if (defined $attr->{value_name}) {
          $args_type = 'named_args';
        } else {
          $args_type = 'args';
        }
      } elsif (defined $attr->{value_names}) {
        $args_type = 'identifiers';
      } elsif (defined $attr->{value_types}) {
        $args_type = 'pair';
      }
      unless ($XAttrArgs->{$attr->{name}}->{$args_type}) {
        $self->onerror->(type => 'webidl:bad args',
                         di => $di,
                         index => $attr->{index},
                         value => $attr->{name},
                         level => 'm');
      }

      if ($attr->{name} eq 'ArrayClass') {
        if (defined $src->{super_name}) {
          #
        } else {
          $dest->{ArrayClass} = 1;
          next;
        }
      } elsif ($attr->{name} eq 'Clamp') {
        if ($src->{readonly}) {
          #
        } else {
          $dest->{Clamp} = 1;
          # XXX MUST NOT use with non-integer type
          next;
        }
      } elsif ($attr->{name} eq 'Constructor') {
        push @constructor, $attr;
        next;
      }

    }
    $self->onerror->(type => 'webidl:not allowed',
                     value => $attr->{name},
                     di => $di,
                     index => $attr->{index},
                     level => 'm');
  }

  if (@constructor) {
    $dest->{Constructor} = ['operation', {
      overload_set => $self->_overload_set
          ($di, \@constructor, type_optional => 1),
    }];
    my $type = $self->_type
        ($di, {type_name => $src->{name}, index => $src->{index}});
    for (values %{$dest->{Constructor}->[1]->{overload_set}}) {
      $_->{type} = $type;
    }
  }

  for (@$XAttrDisallowedCombinations) {
    if ($dest->{$_->[0]} and $dest->{$_->[1]}) {
      $self->onerror->(type => 'webidl:not allowed',
                       value => $_->[1],
                       di => $di,
                       index => $src->{index},
                       level => 'm');
    }
  }
} # _extended_attributes

sub _type ($$$;%) {
  my ($self, $di, $def, %args) = @_;
  my $value;
  if (defined $def->{type}) {
    # XXX warn if float
    # XXX SHOULD NOT use ByteString
    $value = $def->{type};
  } elsif (defined $def->{type_name}) {
    $self->{state}->{has_ref}->{$def->{type_name}}
        ||= [undef, $di, $def->{index}];
    $value = $self->{state}->{has_ref}->{$def->{type_name}}->[0]
        ||= ['ref', $def->{type_name}];
  } elsif (defined $def->{type_parameterized}) {
    $value = [$def->{type_parameterized}->{type_outer},
              $self->_type ($di, {index => $def->{index},
                                  %{$def->{type_parameterized}}})];
  } elsif (defined $def->{type_union}) {
    $value = ['union', {def => [map { $self->_type ($di, {index => $def->{index}, %$_}) } @{$def->{type_union}}]}];
    push @{$self->{state}->{types} ||= []},
        ['union', $value, $di, $def->{index}];
  } elsif ($args{optional}) {
    return undef;
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
      push @{$self->{state}->{types} ||= []},
          ['array', $value, $di, $def->{index}];
      $value = ['array', $value];
      redo NEST;
    }
  } # NEST

  return $value;
} # _type

sub _serialize_type ($$) {
  my ($self, $type) = @_;
  if (ref $type) {
    if ($type->[0] eq 'union') {
      return $type->[0] . '[' . (join ',', map { $self->_serialize_type ($_) } @{$type->[1]->{def}}) . ']';
    } else {
      return $type->[0] . '[' . $self->_serialize_type ($type->[1]) . ']';
    }
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

      $self->_extended_attributes ($di, $_->{arguments}->[$i] => $args->[$i]);
    }

    ## Return type
    my $type = $self->_type ($di, $_, optional => $args{type_optional});
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

    push @{$self->{state}->{args} ||= []}, [$args, $di, $_->{index}];

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

  return \%S;
} # _overload_set

sub end_processing ($) {
  my $self = $_[0];

  ## Resolve type names
  for my $name (keys %{$self->{state}->{has_ref} or {}}) {
    if (defined $self->{defs}->{$name}) {
      $self->{state}->{has_ref}->{$name}->[0]->[0]
          = 'ref_' . $self->{defs}->{$name}->[0];
    }
    unless ($self->{state}->{has_def}->{$name}) {
      $self->onerror->(type => 'webidl:not defined',
                       value => $name,
                       di => $self->{state}->{has_ref}->{$name}->[1],
                       index => $self->{state}->{has_ref}->{$name}->[2],
                       level => 'm');
    }
  } # has_ref

  for (@{$self->{state}->{types} or []}) {
    my ($context, $type, $di, $index) = @$_;
    if ($context eq 'array') {
      if (ref $type and $type->[0] eq 'ref_dictionary') {
        $self->onerror->(type => 'webidl:bad type',
                         di => $di,
                         index => $index,
                         value => $self->_serialize_type ($type),
                         level => 'm');
      }
      # XXX and typedef of dictionary and nullable of dictionary?
    } elsif ($context eq 'union') {
      my $flattened = {};
      my @member = @{$type->[1]->{def}};
      while (@member) {
        my $t = shift @member;
        if (ref $t and $t->[0] eq 'union') {
          for (keys %{$t->[1]->{flattened}}) {
            if (defined $flattened->{$_}) {
              $self->onerror->(type => 'webidl:not distinguishable',
                               value => $_,
                               di => $di,
                               index => $index,
                               level => 'm');
            } else {
              $flattened->{$_} = $t->[1]->{flattened}->{$_};
            }
          }
        } elsif (ref $t and $t->[0] eq 'nullable') {
          if (defined $flattened->{null}) {
            $self->onerror->(type => 'webidl:not distinguishable',
                             value => 'null',
                             di => $di,
                             index => $index,
                             level => 'm');
          } else {
            $flattened->{null} = 'null';
          }
          unshift @member, $t->[1];
        } else {
          my $v = $self->_serialize_type ($t);
          if (defined $flattened->{$v}) {
            $self->onerror->(type => 'webidl:not distinguishable',
                             value => $v,
                             di => $di,
                             index => $index,
                             level => 'm');
          } else {
            $flattened->{$v} = $t;
          }
        }
      }
      $type->[1]->{flattened} = $flattened;
      # XXX and expand typedefs?

      my $dict;
      for (keys %$flattened) {
        if (/^ref_dictionary\[/) {
          $dict = $flattened->{$_};
          last;
        }
      }
      if (defined $dict) {
        $type->[1]->{has_dictionary} = 1;
        if ($flattened->{null}) {
          $self->onerror->(type => 'webidl:bad type',
                           di => $di,
                           index => $index,
                           value => $self->_serialize_type ($dict),
                           level => 'm');
        }
      }

      # XXX more distinguishability checks
    }
  } # types

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

  my $is_supplemental = {};
  for (@{$self->{state}->{implements} or []}) {
    my ($sub, $super, $di, $index) = @$_;
    my $sub_def = $self->{defs}->{$sub} or die;
    my $super_def = $self->{defs}->{$super};
    $is_supplemental->{$super} = 1;

    if (not defined $super_def) {
      $self->onerror->(type => 'webidl:not defined',
                       di => $di,
                       index => $index,
                       value => $super,
                       level => 'm');
    } elsif (not $sub_def->[0] eq $super_def->[0] or
             not $super_def->[0] eq 'interface') {
      $self->onerror->(type => 'webidl:bad type',
                       di => $di,
                       index => $index,
                       value => $super,
                       level => 'm');
    } elsif (($super_def->[1]->{implements} or {})->{$sub} or
             ($sub_def->[1]->{implements} or {})->{$super} or
             $sub eq $super) {
      $self->onerror->(type => 'webidl:cyclic inheritance',
                       di => $di,
                       index => $index,
                       value => $super,
                       level => 'm');
    } else {
      $sub_def->[1]->{implements}->{$super}->{depth} = 1;
      $sub_def->[1]->{implements}->{$super}->{supplemental} = 1;
      $sub_def->[1]->{implements}->{$super}->{consequential} = 1;
      for (keys %{$super_def->[1]->{implements} or {}}) {
        $sub_def->[1]->{implements}->{$_}->{depth}
            = 1 + $super_def->[1]->{implements}->{$_}->{depth};
        $sub_def->[1]->{implements}->{$_}->{supplemental} = 1;
        $is_supplemental->{$_} = 1;
        $sub_def->[1]->{implements}->{$_}->{consequential} = 1;
      }

      for my $n (keys %{$self->{defs}}) {
        my $n_def = $self->{defs}->{$n};
        if (($n_def->[1]->{implements} or {})->{$sub}) {
          die unless $n_def->[0] eq $sub_def->[0];
          for (keys %{$sub_def->[1]->{implements} or {}}) {
            $n_def->[1]->{implements}->{$_}->{depth}
                = $n_def->[1]->{implements}->{$sub}->{depth}
                + $sub_def->[1]->{implements}->{$_}->{depth};
            $n_def->[1]->{implements}->{$_}->{supplemental} = 1;
            $is_supplemental->{$_} = 1;
            $n_def->[1]->{implements}->{$_}->{consequential} = 1
                if $n_def->[1]->{implements}->{$sub}->{consequential};
          }
        }
      }
    }
  } # implements

  for (@{$self->{state}->{implements} or []}) {
    my ($sub, $super, $di, $index) = @$_;
    my $sub_def = $self->{defs}->{$sub} or die;
    if ($is_supplemental->{$sub}) {
      $self->onerror->(type => 'webidl:implements implements',
                       di => $di,
                       index => $index,
                       value => $sub,
                       level => 'w');
    }
  }

  ## Argument optionality
  for (@{$self->{state}->{args} or []}) {
    my ($args, $di, $index) = @$_;

    for (reverse @$args) {
      if (ref $_->{type} and
          ($_->{type}->[0] eq 'ref_dictionary' or
           ($_->{type}->[0] eq 'union' and
            $_->{type}->[1]->{has_dictionary}))) {
        if ($_->{optionality} eq 'required') {
          $self->onerror->(type => 'webidl:bad optionality',
                           di => $di,
                           index => $index,
                           value => $_->{name},
                           level => 'm');
        }
        $_->{value} = ['dictionary_value', {}] unless defined $_->{value};
      }
      last if $_->{optionality} eq 'required';
    }

    delete $_->{index}, delete $_->{type_serialized} for @$args;
  }

  ## Dictionary members
  my @dict_name = grep {
    $self->{defs}->{$_}->[0] eq 'dictionary';
  } keys %{$self->{defs}};
  for my $def_name (@dict_name) {
    my $def = $self->{defs}->{$def_name};
    my $included = {};
    for my $mem_name (keys %{$def->[1]->{members}}) {
      my $mem = $def->[1]->{members}->{$mem_name};
      next unless $mem->[0] eq 'dictionary_member';
      my @type = $mem->[1]->{type};
      while (@type) {
        my $type = shift @type;
        if (not ref $type) {
          #
        } elsif ($type->[0] eq 'ref_dictionary') {
          $included->{$type->[1]} = 1;
          for (keys %{$self->{defs}->{$type->[1]}->[1]->{implements} or {}}) {
            $included->{$_} = 1;
          }
        } elsif ($type->[0] eq 'array' or
                 $type->[0] eq 'nullable' or
                 $type->[0] eq 'sequence') {
          push @type, $type->[1];
        } elsif ($type->[0] eq 'union') {
          push @type, @{$type->[1]->{def}};
        }
      }
    }
    $def->[1]->{dictionaries_included_by_members}
        = $included if keys %$included;
  } # defs
  for my $def_name (@dict_name) {
    my $def = $self->{defs}->{$def_name};
    for (keys %{$def->[1]->{implements} or {}}) {
      for (keys %{$self->{defs}->{$_}->[1]->{dictionaries_included_by_members} or {}}) {
        $def->[1]->{dictionaries_included_by_members}->{$_} = 1;
      }
    }
  } # defs
  {
    my $changed = 0;
    for my $def_name (@dict_name) {
      my $def = $self->{defs}->{$def_name};
      for (keys %{$def->[1]->{dictionaries_included_by_members} or {}}) {
        for (keys %{$self->{defs}->{$_}->[1]->{dictionaries_included_by_members} or {}}) {
          unless ($def->[1]->{dictionaries_included_by_members}->{$_}) {
            $def->[1]->{dictionaries_included_by_members}->{$_} = 1;
            $changed = 1;
          }
        }
      }
    } # defs
    redo if $changed;
  }
  for my $def_name (@dict_name) {
    my $def = $self->{defs}->{$def_name};
    if (($def->[1]->{dictionaries_included_by_members} or {})->{$def_name}) {
      $self->onerror->(type => 'webidl:cyclic inheritance',
                       value => $def_name,
                       level => 'm');
    }
  } # defs
  # XXX typedefs?

        # XXX warn if an object implements multiple interfaces with a special operation

        # XXX If there is named*, there MUST be namedGetter
        # XXX If there is indexed*, there MUST be indexedGetter
        # XXX no special operation on callback interface
        # XXX MUST NOT use "next" as an interface member on iterator object interface or its consequential interface
        # XXX no duplicate iterator amongst consequential interfaces
        # XXX no duplicate iterator object amongst consequential interfaces
        # XXX inherited dictionary's member's name MUST NOT be used
        # XXX there MUST NOT be identifier conflicting member on consequential interfaces
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

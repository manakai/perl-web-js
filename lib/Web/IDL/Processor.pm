package Web::IDL::Processor;
use strict;
use warnings;
no warnings 'utf8';
use warnings FATAL => 'recursion';
our $VERSION = '4.0';
use Web::IDL::_Defs;

sub new ($) {
  return bless {processed => {idl_defs => {}}}, $_[0];
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
        $args{index} || 0,
        (defined $args{value} ? ' "' . $args{value} . '"' : ''),
        defined $args{di} ? $args{di} : -1;
  };
} # onerror

sub process_parsed_struct ($$$) {
  my ($self, $di, $in) = @_;
  local $self->{spec} = $in->{spec};
  local $self->{obsolete} = $in->{obsolete};
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
          if ($Web::IDL::_Defs->{reserved}->{$def->{definition_type}}->{$def->{name}}) {
            $self->onerror->(type => 'webidl:reserved',
                             value => $def->{name},
                             di => $di,
                             index => $def->{index},
                             level => 'm');
          }
          $self->{state}->{has_def}->{$def->{name}} = $def->{definition_type};
        }

        if ($def->{partial}) {
          if (not defined $self->{processed}->{idl_defs}->{$def->{name}}->[0] or
              $self->{processed}->{idl_defs}->{$def->{name}}->[0] eq $def->{definition_type} or
              ($self->{processed}->{idl_defs}->{$def->{name}}->[0] eq 'callback_interface' and
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
          $self->{processed}->{idl_defs}->{$def->{name}}->[0] ||= $def->{definition_type};
        } elsif ($def->{definition_type} eq 'interface' and $def->{callback}) {
          $self->{processed}->{idl_defs}->{$def->{name}}->[0] = 'callback_interface';
        } else {
          if (not defined $self->{processed}->{idl_defs}->{$def->{name}}->[0] or
              $self->{processed}->{idl_defs}->{$def->{name}}->[0] eq $def->{definition_type} or
              ($self->{processed}->{idl_defs}->{$def->{name}}->[0] eq 'interface' and
               $def->{definition_type} eq 'callback_interface')) {
            #
          } else {
            $self->onerror->(type => 'webidl:bad type',
                             di => $di,
                             index => $def->{index},
                             value => $def->{definition_type},
                             level => 'm');
            $self->{processed}->{idl_defs}->{$def->{name}}->[1] = {};
          }
          $self->{processed}->{idl_defs}->{$def->{name}}->[0] = $def->{definition_type};
        }
        my $props = $self->{processed}->{idl_defs}->{$def->{name}}->[1] ||= {};

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

        my $xattr_opts = {};
        if ($def->{definition_type} eq 'callback') {
          $props->{overload_set} = $self->_overload_set ($di, [$def]);

          $props->{TreatNonObjectAsNull}
              = delete [values %{$props->{overload_set}}]->[0]->{TreatNonObjectAsNull};
          delete $props->{TreatNonObjectAsNull}
              unless defined $props->{TreatNonObjectAsNull};
        } else {
          $self->_extended_attributes ($di, $def => $props, $xattr_opts);
        }

        if ($def->{definition_type} eq 'enum') {
          my $vals = {};
          for (@{$def->{value_items}}) {
            if (defined $vals->{$_->{value_string}}) {
              $self->onerror->(type => 'webidl:duplicate',
                               value => $_->{value_string},
                               di => $di,
                               index => $def->{index},
                               level => 'm');
            } else {
              $vals->{$_->{value_string}} = {};
              $vals->{$_->{value_string}}->{spec} = $self->{spec}
                  if defined $self->{spec};
              $vals->{$_->{value_string}}->{id} = $_->{id}
                  if defined $_->{id};
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

          for my $key (sort { $a cmp $b } keys %op) {
            my $mem = {member_type => 'operation',
                       static => $op{$key}->[0]->{static},
                       special => ($key =~ /$;/o ? undef : $key),
                       name => $op{$key}->[0]->{name},
                       index => $op{$key}->[0]->{index}};
            $mem->{overload_set} = $self->_overload_set
                ($di, $op{$key}, special => $mem->{special});

            my $id_name = $key;
            $id_name =~ s/^named_//;
            $id_name =~ s/^indexed_//;
            my $id = [map { $_->{$id_name . '_id'} } @{$op{$key}}]->[0];

            my $unforgeable;
            my $non_unforgeable;
            my $exposed;
            my $bad_exposed;
            for (sort { $a cmp $b } keys %{$mem->{overload_set}}) {
              my $v = $mem->{overload_set}->{$_};
              if (delete $v->{Unforgeable}) {
                $unforgeable = 1;
              } else {
                $non_unforgeable = 1;
              }
              if (defined $v->{_exposed}) {
                if (defined $exposed) {
                  unless ((join $;, @{$v->{_exposed}}) eq (join $;, @$exposed)) {
                    $bad_exposed = 1;
                  }
                  delete $v->{_exposed};
                } else {
                  $exposed = delete $v->{_exposed};
                }
              } else {
                $bad_exposed = 1;
              }
              for my $key (qw(obsolete spec id)) {
                $mem->{$key} = delete $v->{$key} if defined $v->{$key};
              }
            } # $v
            $mem->{id} = $id if defined $id;
            if ($unforgeable) {
              $mem->{Unforgeable} = 1;
              if (defined $non_unforgeable) {
                $self->onerror->(type => 'webidl:bad unforgeablility',
                                 di => $di,
                                 index => $op{$key}->[0]->{index},
                                 level => 'm');
              }
            }
            if (defined $exposed) {
              $mem->{_exposed} = $exposed;
              if ($bad_exposed) {
                $self->onerror->(type => 'webidl:inconsistent',
                                 di => $di,
                                 index => $op{$key}->[0]->{index},
                                 value => '[Exposed]',
                                 level => 'm');
              }
            }

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
                  for (qw(overload_set Unforgeable _exposed
                          obsolete spec id)) {
                    $mem_props->{$_} = $mem->{$_} if defined $mem->{$_};
                  }

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
                  if ($Web::IDL::_Defs->{reserved}->{$mem->{member_type}}->{$mem->{name}}) {
                    $self->onerror->(type => 'webidl:reserved',
                                     value => $mem->{name},
                                     di => $di,
                                     index => $mem->{index},
                                     level => 'm');
                  }

                  if ($mem->{member_type} eq 'operation' and $mem->{static}) {
                    $props->{members}->{$mem->{name}}->[0] = 'static_operation';
                    if ($self->{processed}->{idl_defs}->{$def->{name}}->[0] eq 'callback_interface') {
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

                  for (qw(overload_set Unforgeable _exposed
                          obsolete spec id)) {
                    $mem_props->{$_} = $mem->{$_} if defined $mem->{$_};
                  }
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
                if ($Web::IDL::_Defs->{reserved}->{$mem->{member_type}}->{$mem->{name}}) {
                  $self->onerror->(type => 'webidl:reserved',
                                   value => $mem->{name},
                                   di => $di,
                                   index => $mem->{index},
                                   level => 'm');
                }

                if ($mem->{member_type} eq 'attribute' and $mem->{static}) {
                  $props->{members}->{$mem->{name}}->[0] = 'static_attribute';
                  if ($self->{processed}->{idl_defs}->{$def->{name}}->[0] eq 'callback_interface') {
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
                      $props->{stringifier} = ['ref_attribute', $mem->{name}];
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

                $mem_props->{_exposed} = $xattr_opts->{Exposed}
                    if defined $xattr_opts->{Exposed};
                $self->_extended_attributes ($di, $mem => $mem_props, {});
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

                $mem_props->{_exposed} = $xattr_opts->{Exposed}
                    if defined $xattr_opts->{Exposed};
                $self->_extended_attributes ($di, $mem => $mem_props, {});
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

                $mem_props->{_exposed} = $xattr_opts->{Exposed}
                    if defined $xattr_opts->{Exposed};
                $self->_extended_attributes ($di, $mem => $mem_props, {});
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

                $mem_props->{_exposed} = $xattr_opts->{Exposed}
                    if defined $xattr_opts->{Exposed};
                $self->_extended_attributes ($di, $mem => $mem_props, {});
              }
            } else {
              $self->onerror->(type => 'webidl:unknown',
                               value => $mem->{member_type},
                               level => 'u');
            } # member_type
          }
        } # has member

        # XXX SHOULD NOT define new callback interface with only a
        # single operation
      }
    } elsif ($def->{definition_type} eq 'implements') {
      push @{$self->{state}->{implements} ||= []},
          [$def->{name} => $def->{super_name}, $di, $def->{index}];
      $self->_extended_attributes ($di, $def => {}, {});
    } else {
      $self->onerror->(type => 'webidl:unknown',
                       value => $def->{definition_type},
                       level => 'u');
    }
  } # definitions
} # process_parsed_struct

sub _extended_attributes ($$$$$) {
  my ($self, $di, $src, $dest, $dest_context) = @_;
  my $has_xattrs = {};
  my @constructor;
  my $named_constructors = {};
  for my $attr (@{$src->{extended_attributes} or []}) {
    my $context = $src->{definition_type} || $src->{member_type} || 'argument';
    $context = 'partial_' . $context if $src->{partial};
    $context = 'static_' . $context if $src->{static};
    $context = 'callback_' . $context if $src->{callback};
    if ($Web::IDL::_Defs->{allowed_xattrs}->{$context}->{$attr->{name}}) {
      if ($has_xattrs->{$attr->{name}}) {
        unless ($Web::IDL::_Defs->{xattr_multiple}->{$attr->{name}}) {
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
        if (defined $attr->{value_names}) {
          $args_type = 'named_args';
        } else {
          $args_type = 'args';
        }
      } elsif (defined $attr->{value_names}) {
        $args_type = @{$attr->{value_names}} == 1 ? 'id' : 'id_list';
      } elsif (defined $attr->{value_types}) {
        $args_type = 'pair';
      }
      unless ($Web::IDL::_Defs->{xattr_args}->{$attr->{name}}->{$args_type}) {
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
      } elsif ($attr->{name} eq 'MapClass') {
        if (defined $src->{super_name}) {
          #
        } else {
          my $t = $attr->{value_types};
          if (defined $t) {
            $dest->{MapClass}->{key_type} = $self->_type
                ($di, {index => $attr->{index}, %{$t->[0]}});
            $dest->{MapClass}->{value_type} = $self->_type
                ($di, {index => $attr->{index}, %{$t->[1]}});

            # XXX interface members' restrictions
          }
          next;
        }
      } elsif ($attr->{name} eq 'Clamp' or
               $attr->{name} eq 'EnforceRange') {
        if ($src->{readonly}) {
          #
        } else {
          $dest->{$attr->{name}} = 1;
          # XXX MUST NOT use with non-integer type
          next;
        }
      } elsif ($attr->{name} eq 'Constructor') {
        push @constructor, $attr;
        next;
      } elsif ($attr->{name} eq 'NamedConstructor') {
        push @{$named_constructors->{$attr->{value_names}->[0]} ||= []}, $attr
            if @{$attr->{value_names} or []};
        next;
      } elsif ($attr->{name} eq 'EnsureUTF16') {
        $dest->{EnsureUTF16} = 1;
        # XXX warn unless type is DOMString
        # XXX warn if readonly
        next;
      } elsif ($attr->{name} eq 'ImplicitThis') {
        $dest->{$attr->{name}} = 1;
        next;
      } elsif ($attr->{name} eq 'LenientThis' or
               $attr->{name} eq 'TreatNonObjectAsNull') {
        $dest->{$attr->{name}} = 1;
        # XXX SHOULD NOT be used
        next;
      } elsif ($attr->{name} eq 'TreatNonCallableAsNull') {
        $dest->{TreatNonObjectAsNull} = 1;
        $self->onerror->(type => 'webidl:obsolete',
                         value => $attr->{name},
                         di => $di,
                         index => $attr->{index},
                         level => 'm');
        next;
      } elsif ($attr->{name} eq 'NewObject') {
        if (not defined $src->{name}) {
          #
        } else {
          # XXX return type MUST be interface
          $dest->{$attr->{name}} = 1;
          next;
        }
      } elsif ($attr->{name} eq 'SameObject') {
        if ($src->{readonly}) {
          # XXX type MUST be interface, array or object
          $dest->{$attr->{name}} = 1;
          next;
        } else {
          #
        }
      } elsif ($attr->{name} eq 'NoInterfaceObject') {
        $dest->{$attr->{name}} = 1;
        # XXX SHOULD NOT be used
        # XXX MUST NOT be used if there is any static operation
        # XXX MUST NOT be used on callback interface with no constant
        next;
      } elsif ($attr->{name} eq 'OverrideBuiltins') {
        $dest->{$attr->{name}} = 1;
        # XXX MUST NOT be used unless interface or partial interface with named getter
        next;
      } elsif ($attr->{name} eq 'PutForwards') {
        if (@{$attr->{value_names} or []}) {
          if ($dest->{setter}) {
            $self->onerror->(type => 'webidl:duplicate',
                             value => $attr->{name},
                             di => $di,
                             index => $attr->{index},
                             level => $dest->{setter} eq 1 ? 'w' : 'm');
          }
          $dest->{setter} = ['ref_attribute', $attr->{value_names}->[0]];
          # XXX there MUST be referenced attribute
          # XXX there MUST NOT be cycle
          # XXX MUST NOT be used on callback interface's attribute
        }
        next;
      } elsif ($attr->{name} eq 'Replaceable') {
        if ($dest->{setter}) {
          $self->onerror->(type => 'webidl:duplicate',
                           value => $attr->{name},
                           di => $di,
                           index => $attr->{index},
                           level => $dest->{setter} eq 1 ? 'w' : 'm');
        }
        $dest->{setter} = 'replaceable';
        # XXX MUST NOT be used on callback interface
        next;
      } elsif ($attr->{name} eq 'TreatNullAs') {
        if (@{$attr->{value_names} or []}) {
          if ($attr->{value_names}->[0] eq 'EmptyString') {
            $dest->{$attr->{name}} = $attr->{value_names}->[0];
            # XXX type MUST be DOMString
            # XXX If operation return value, it MUST be in callback interface
          } else {
            $self->onerror->(type => 'webidl:bad args',
                             di => $di,
                             index => $attr->{index},
                             value => $attr->{name},
                             level => 'm');
          }
        }
        next;
      } elsif ($attr->{name} eq 'Unforgeable') {
        $dest->{$attr->{name}} = 1;
        # XXX restrictions on consequential interfaces
        next;
      } elsif ($attr->{name} eq 'Global' or
               $attr->{name} eq 'PrimaryGlobal') {
        $dest->{Global} = 1;
        if (defined $attr->{value_names}) {
          for (@{$attr->{value_names}}) {
            $self->{processed}->{global_names}->{$_}->{$src->{name}} = 1;
          }
        } else {
          $self->{processed}->{global_names}->{$src->{name}}->{$src->{name}} = 1;
        }
        if ($attr->{name} eq 'PrimaryGlobal') {
          if (defined $self->{processed}->{primary_global}) {
            $self->onerror->(type => 'webidl:duplicate',
                             value => $attr->{name},
                             di => $di,
                             index => $attr->{index},
                             level => 'm');
          } else {
            $self->{processed}->{primary_global} = $src->{name};
          }
        }
        # XXX If partial interface, it MUST have named getter.
        # XXX interface and consequential interfaces MUST NOT have duplicate identifiers, stringifiers, serializers, iterators
        # XXX MUST NOT have named setter, creattor, deleter
        # XXX MUST NOT inherit interface with OverrideBuiltins
        # XXX MUST NOT inherit this interface
        next;
      } elsif ($attr->{name} eq 'Exposed') {
        if (defined $src->{member_type}) { # member
          if (defined $dest->{_exposed}) {
            $self->onerror->(type => 'webidl:not allowed',
                             value => $attr->{name},
                             di => $di,
                             index => $attr->{index},
                             level => 'm');
          }
          $dest->{_exposed} = $attr->{value_names} || [];
          # XXX MUST NOT be specified for exception's const
          # XXX MUST be subset of interface's exposure set
        } else { # interface
          if ($src->{partial}) {
            $dest_context->{Exposed} = $attr->{value_names} || [];
            # XXX
          } else {
            $self->{state}->{exposed}->{$src->{name}} = $attr->{value_names} || [];
          }
        }
        # XXX for dictionary, there MUST be Constructor
        # XXX exposure sets MUST be subset of consequential's exposure sets
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
  for (sort { $a cmp $b } keys %{$named_constructors}) {
    $dest->{NamedConstructor}->{$_} = ['operation', {
      overload_set => $self->_overload_set
          ($di, $named_constructors->{$_}, type_optional => 1),
    }];
    my $type = $self->_type
        ($di, {type_name => $src->{name}, index => $src->{index}});
    for (values %{$dest->{NamedConstructor}->{$_}->[1]->{overload_set}}) {
      $_->{type} = $type;
    }
  }

  for (@{$Web::IDL::_Defs->{xattr_disallowed}}) {
    if ($dest->{$_->[0]} and $dest->{$_->[1]}) {
      $self->onerror->(type => 'webidl:not allowed',
                       value => $_->[0],
                       di => $di,
                       index => $src->{index},
                       level => 'm');
    }
  }

  unless ($src->{partial}) {
    $dest->{id} = $src->{id} if defined $src->{id};
    $dest->{spec} = $self->{spec} if defined $self->{spec};
    $dest->{obsolete} = 1 if $self->{obsolete};
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
    return ['ref_attribute', $obj->{value_name}];
    # XXX MUST be an attribute of serializable type
  } elsif (defined $obj->{value_name} and
           defined $args{context} and $args{context} eq 'iterator') {
    return ['ref_interface', $obj->{value_name}];
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
      push @v, map { ['ref_attribute', $_] } @{$o->{value_names}};
    }
    return \@v;
  } elsif ($obj->{value_empty_sequence}) {
    return ['sequence_value', []];
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
      if ($Web::IDL::_Defs->{reserved}->{argument}->{$name}) {
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

      $args->[$i]->{value} = $self->_value
          ($di, $_->{arguments}->[$i], optional => 1);
      delete $args->[$i]->{value} unless defined $args->[$i]->{value};
      # XXX integer value MUST be in range
      # XXX float value or literal MUST be in range
      # XXX value type MUST be compat with type
      # XXX if type is enumeration, value MUST be one of them

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
        if ($_->{arguments}->[$i]->{optional}) {
          $args->[$i]->{optionality} = 'optional';
        } elsif (defined $args->[$i]->{value}) {
          ## Not in spec
          $self->onerror->(type => 'webidl:non-optional default',
                           di => $di,
                           index => $_->{arguments}->[$i]->{index},
                           value => $name,
                           level => 'm');
          $args->[$i]->{optionality} = 'optional';
        } else {
          $args->[$i]->{optionality} = 'required';
        }
      }
      if (defined $args{special} and
          not $args->[$i]->{optionality} eq 'required') {
        $self->onerror->(type => 'webidl:bad optionality:special',
                         di => $di,
                         index => $_->{arguments}->[$i]->{index},
                         value => $name,
                         level => 'm');
      }

      $self->_extended_attributes
          ($di, $_->{arguments}->[$i] => $args->[$i], {});
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

    my $xa_props = {};
    $self->_extended_attributes ($di, $_ => $xa_props, {});

    ## 5.4.
    push @$S, {type => $type, args => $args,
               index => $_->{index}, %$xa_props};

    push @{$self->{state}->{args} ||= []}, [$args, $di, $_->{index}];

    ## 5.6.
    my $l = $n - 1;

    ## 5.5.
    if (@$args and $args->[-1]->{optionality} eq 'variadic') {
      ## 5.5.1.
      push @$S, {type => $type, args => [@$args[0..($#$args-1)]],
                 index => $_->{index}, %$xa_props};
      
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
                 index => $_->{index}, %$xa_props};

      ## 5.7.3.
      $l--;
    }

    ## 5.8.
    if (@$args and $l == 0 and $args->[0]->{optionality} eq 'optional') {
      push @$S, {type => $type, args => [], index => $_->{index}, %$xa_props};
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
  for my $name (sort { $a cmp $b } keys %{$self->{state}->{has_ref} or {}}) {
    if (defined $self->{processed}->{idl_defs}->{$name}) {
      $self->{state}->{has_ref}->{$name}->[0]->[0]
          = 'ref_' . $self->{processed}->{idl_defs}->{$name}->[0];
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
          for (sort { $a cmp $b } keys %{$t->[1]->{flattened}}) {
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
      } # @member
      $type->[1]->{flattened} = $flattened;
      # XXX and expand typedefs?

      my $dict;
      for (sort { $a cmp $b } keys %$flattened) {
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
    my $sub_def = $self->{processed}->{idl_defs}->{$sub} or die;
    my $super_def = $self->{processed}->{idl_defs}->{$super};

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

      for my $n (keys %{$self->{processed}->{idl_defs}}) {
        my $n_def = $self->{processed}->{idl_defs}->{$n};
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
    my $sub_def = $self->{processed}->{idl_defs}->{$sub};
    my $super_def = $self->{processed}->{idl_defs}->{$super};
    $is_supplemental->{$super} = 1;

    if (not defined $sub_def) {
      $self->onerror->(type => 'webidl:not defined',
                       di => $di,
                       index => $index,
                       value => $sub,
                       level => 'm');
      next;
    }

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

      for my $n (keys %{$self->{processed}->{idl_defs}}) {
        my $n_def = $self->{processed}->{idl_defs}->{$n};
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
    my $sub_def = $self->{processed}->{idl_defs}->{$sub} or next;
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
  my @dict_name = sort { $a cmp $b } grep {
    $self->{processed}->{idl_defs}->{$_}->[0] eq 'dictionary';
  } keys %{$self->{processed}->{idl_defs}};
  for my $def_name (@dict_name) {
    my $def = $self->{processed}->{idl_defs}->{$def_name};
    my $included = {};
    for my $mem_name (sort { $a cmp $b } keys %{$def->[1]->{members}}) {
      my $mem = $def->[1]->{members}->{$mem_name};
      next unless $mem->[0] eq 'dictionary_member';
      my @type = $mem->[1]->{type};
      while (@type) {
        my $type = shift @type;
        if (not ref $type) {
          #
        } elsif ($type->[0] eq 'ref_dictionary') {
          $included->{$type->[1]} = 1;
          for (keys %{$self->{processed}->{idl_defs}->{$type->[1]}->[1]->{implements} or {}}) {
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
    my $def = $self->{processed}->{idl_defs}->{$def_name};
    for (keys %{$def->[1]->{implements} or {}}) {
      for (keys %{$self->{processed}->{idl_defs}->{$_}->[1]->{dictionaries_included_by_members} or {}}) {
        $def->[1]->{dictionaries_included_by_members}->{$_} = 1;
      }
    }
  } # defs
  {
    my $changed = 0;
    for my $def_name (@dict_name) {
      my $def = $self->{processed}->{idl_defs}->{$def_name};
      for (keys %{$def->[1]->{dictionaries_included_by_members} or {}}) {
        for (keys %{$self->{processed}->{idl_defs}->{$_}->[1]->{dictionaries_included_by_members} or {}}) {
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
    my $def = $self->{processed}->{idl_defs}->{$def_name};
    if (($def->[1]->{dictionaries_included_by_members} or {})->{$def_name}) {
      $self->onerror->(type => 'webidl:cyclic inheritance',
                       value => $def_name,
                       level => 'm');
    }
  } # defs
  # XXX typedefs?

  ## Exposedness
  unless (defined $self->{processed}->{primary_global}) {
    $self->onerror->(type => 'webidl:not defined',
                     value => '[PrimaryGlobal]',
                     level => 'w');
  }
  for my $def_name (sort { $a cmp $b } keys %{$self->{processed}->{idl_defs}}) {
    my $def = $self->{processed}->{idl_defs}->{$def_name};
    if ($def->[0] eq 'interface' or
        $def->[0] eq 'callback_interface' or
        ($def->[0] eq 'dictionary' and defined $def->[1]->{Constructor})) {
      if (defined $self->{state}->{exposed}->{$def_name}) {
        $def->[1]->{Exposed} = {};
        for my $gname (@{$self->{state}->{exposed}->{$def_name} or []}) {
          if (defined $self->{processed}->{global_names}->{$gname}) {
            for (keys %{$self->{processed}->{global_names}->{$gname} or {}}) {
              $def->[1]->{Exposed}->{$_} = 1;
            }
          } else {
            $self->onerror->(type => 'webidl:not defined',
                             value => $gname,
                             level => 'm');
          }
        }
      } else { # No [Exposed]
        if (defined $self->{processed}->{primary_global}) {
          $def->[1]->{Exposed}->{$self->{processed}->{primary_global}} = 1;
        } else {
          if (defined $self->{processed}->{global_names}) {
            $def->[1]->{Exposed} = {};
          } else {
            #
          }
        }
      }

      for my $mem_name (sort { $a cmp $b } keys %{$def->[1]->{members}}) {
        my $mem = $def->[1]->{members}->{$mem_name};
        if (defined $mem->[1]->{_exposed}) {
          $mem->[1]->{Exposed} = {};
          for my $gname (@{delete $mem->[1]->{_exposed}}) {
            if (defined $self->{processed}->{global_names}->{$gname}) {
              for (sort { $a cmp $b } keys %{$self->{processed}->{global_names}->{$gname} or {}}) {
                if ($def->[1]->{Exposed}->{$_}) {
                  $mem->[1]->{Exposed}->{$_} = 1;
                } else {
                  $self->onerror->(type => 'webidl:not allowed',
                                   value => "[Exposed=$_]",
                                   level => 'w');
                }
              }
            } else {
              $self->onerror->(type => 'webidl:not defined',
                               value => $gname,
                               level => 'm');
            }
          }
        }
      }
    } elsif ($def->[0] eq 'exception') {
      if (defined $self->{processed}->{global_names}) {
        $def->[1]->{Exposed} = {};
        for (values %{$self->{processed}->{global_names}}) {
          $def->[1]->{Exposed}->{$_} = 1 for keys %$_;
        }
      } else {
        #
      }
    }
  } # idl_defs
  # XXX error if interfaces in {implements} are not Exposed to same set
  # of globals

  ## Interface objects
  my $gmembers = $self->{processed}->{global_members} ||= {};
  for my $def_name (sort { $a cmp $b } keys %{$self->{processed}->{idl_defs}}) {
    my $def = $self->{processed}->{idl_defs}->{$def_name};
    if ($def->[0] eq 'interface' or
        $def->[0] eq 'callback_interface' or
        $def->[0] eq 'exception' or
        $def->[0] eq 'dictionary') {
      my @key;
      for (sort { $a cmp $b } keys %{$def->[1]->{NamedConstructor} or {}}) {
        if (defined $gmembers->{$_}) {
          $self->onerror->(type => 'webidl:duplicate',
                           value => $_,
                           level => 'm');
        } else {
          $gmembers->{$_} = $def->[1]->{NamedConstructor}->{$_};
          push @key, $_;
        }
      }
      delete $def->[1]->{NamedConstructor};

      if (defined $def->[1]->{Constructor}) {
        if (defined $gmembers->{$def_name}) {
          $self->onerror->(type => 'webidl:duplicate',
                           value => $def_name,
                           level => 'm');
        } else {
          $gmembers->{$def_name} = delete $def->[1]->{Constructor};
          push @key, $def_name;
        }
      } elsif ($def->[1]->{NoInterfaceObject} or
               $def->[0] eq 'dictionary' or
               ($def->[0] eq 'callback_interface' and
                not grep { $_->[0] eq 'const' } values %{$def->[1]->{members}})) {
        #
      } else {
        if (defined $gmembers->{$def_name}) {
          $self->onerror->(type => 'webidl:duplicate',
                           value => $def_name,
                           level => 'm');
        } else {
          $gmembers->{$def_name} = ['object', {}];
          push @key, $def_name;
        }
      }
      for (@key) {
        $gmembers->{$_}->[1]->{Exposed} = $def->[1]->{Exposed}
            if defined $def->[1]->{Exposed};
      }
    }
  }

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

sub processed ($) {
  return $_[0]->{processed};
} # processed

1;

=head1 LICENSE

Copyright 2014 Wakaba <wakaba@suikawiki.org>.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

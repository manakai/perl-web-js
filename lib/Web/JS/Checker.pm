package Web::JS::Checker;
use strict;
use warnings;
our $VERSION = '1.0';

sub new ($) {
  return bless {}, $_[0];
} # new

sub impl ($;$) {
  if (@_ > 1) {
    $_[0]->{impl} = $_[1];
  }
  return $_[0]->{impl} || die "|impl| is not set";
} # impl

sub _obj ($) {
  my $self = $_[0];
  return $self->{obj} ||= do {
    my $cls = 'Web::JS::Impl::' . $self->impl;
    eval qq{ require $cls } or die $@;
    $cls->new;
  };
} # _obj

sub onerror ($;$) {
  return shift->_obj->onerror (@_);
} # onerror

sub check_char_string ($$) {
  return shift->_obj->check_char_string (@_);
} # check_char_string

1;

=head1 LICENSE

Copyright 2014 Wakaba <wakaba@suikawiki.org>.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

package Web::JS::Impl::JE;
use strict;
use warnings;
our $VERSION = '1.0';
use JE;

sub new ($) {
  return bless {}, $_[0];
} # new

sub onerror ($;$) {
  if (@_ > 1) {
    $_[0]->{onerror} = $_[1];
  }
  return $_[0]->{onerror} ||= sub { };
} # onerror

sub _obj ($) {
  return $_[0]->{obj} ||= JE->new (html_mode => 1);
} # _obj

sub check_char_string ($$) {
  my $self = $_[0];
  unless ($self->_obj->parse ($_[1], '@@FILE@@', 1)) {
    my $msg = '' . $@->prop ('message');
    $msg =~ s/[\x0D\x0A]+\z//;
    $msg =~ s/ at \@\@FILE\@\@, line ([0-9]+)\.$//;
    $self->onerror->(type => 'js:parse error',
                     text => $msg,
                     line => $1 || 1,
                     column => 1,
                     level => 'm');
  }
  return undef;
} # check_char_string

1;

=head1 LICENSE

Copyright 2014 Wakaba <wakaba@suikawiki.org>.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

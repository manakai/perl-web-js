use strict;
use warnings;
use Path::Class;
use lib glob file (__FILE__)->dir->parent->parent->subdir ('t_deps', 'modules', '*', 'lib');
use Test::More;
use Test::Differences;
use Test::X1;
use Web::JS::Checker;

for my $test (
  ['' => []],
  ['var hoge;' => []],
  ['var hoge fuga;' => [
    {type => 'js:parse error',
     text => 'Expected semicolon, \'}\' or end of line but found \' fuga;\'',
     line => 1, column => 1, level => 'm'},
  ]],
  ["<!--
var hoge;
-->" => []],
) {
  test {
    my $c = shift;
    my $checker = Web::JS::Checker->new;
    $checker->impl ('JE');
    my @error;
    $checker->onerror (sub {
      push @error, {@_};
    });
    $checker->check_char_string ($test->[0]);
    eq_or_diff \@error, $test->[1];
    done $c;
  } n => 1;
}

run_tests;

=head1 LICENSE

Copyright 2014 Wakaba <wakaba@suikawiki.org>.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

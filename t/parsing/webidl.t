use strict;
use warnings;
use Path::Tiny;
use lib glob path (__FILE__)->parent->parent->parent->child ('t_deps/modules/*/lib');
use Test::X1;
use Test::HTCT::Parser;
use Test::Differences;
use JSON::PS;
use Web::IDL::Parser;

my $data_path = path (__FILE__)->parent->parent->parent->child ('t_deps/tests/webidl/parsing');

for my $path ($data_path->children (qr/\.dat$/)) {
  for_each_test $path, {
    data => {is_prefixed => 1},
    errors => {is_list => 1},
    parsed => {is_prefixed => 1},
  }, sub {
    my $test = shift;
    test {
      my $c = shift;

      my $parser = Web::IDL::Parser->new;
      my @error;
      $parser->onerror (sub {
        my %args = @_;
        push @error, join ';',
            $args{index},
            $args{type}, $args{text} || '',
            $args{value} || '',
            $args{level};
      });

      $parser->parse_char_string ($test->{data}->[0]);

      my $expected = json_chars2perl $test->{parsed}->[0];
      eq_or_diff perl2json_chars_for_record $parser->parsed_struct,
                 perl2json_chars_for_record $expected;

      eq_or_diff \@error, $test->{errors}->[0] || [];

      done $c;
    } n => 2, name => [$path, $test->{data}->[0]];
  };
}

run_tests;

=head1 LICENSE

Copyright 2014 Wakaba <wakaba@suikawiki.org>.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

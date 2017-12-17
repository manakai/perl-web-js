use strict;
use warnings;
use Path::Tiny;
use lib glob path (__FILE__)->parent->parent->parent->child ('t_deps/modules/*/lib');
use Test::X1;
use Test::HTCT::Parser;
use Test::Differences;
use JSON::PS;
use Web::IDL::Parser;
use Web::IDL::Processor;

my $data_path = path (__FILE__)->parent->parent->parent->child ('t_deps/tests/webidl/processing');

for my $path ($data_path->children (qr/\.dat$/)) {
  for_each_test $path, {
    data => {is_prefixed => 1, multiple => 1},
    errors => {is_list => 1},
    processed => {is_prefixed => 1},
  }, sub {
    my $test = shift;
    test {
      my $c = shift;

      my $parser = Web::IDL::Parser->new;
      my @error;
      my $default_di;
      $parser->onerror (sub {
        my %args = @_;
        push @error, join ';',
            $args{di} || $default_di,
            defined $args{index} ? $args{index} : '',
            $args{type}, $args{text} || '',
            $args{value} || '',
            $args{level};
      });

      my $processor = Web::IDL::Processor->new;
      $processor->onerror ($parser->onerror);

      for (0..$#{$test->{data}}) {
        $default_di = $_ + 1;
        $parser->parse_char_string ($test->{data}->[$_]->[0]);
        $processor->process_parsed_struct ($_+1, $parser->parsed_struct);
      }
      $processor->end_processing;

      my $expected = json_chars2perl $test->{processed}->[0];
      if ($expected->{idl_defs}) {
        eq_or_diff perl2json_chars_for_record $processor->processed,
                   perl2json_chars_for_record $expected;
      } else {
        eq_or_diff perl2json_chars_for_record $processor->processed->{idl_defs},
                   perl2json_chars_for_record $expected;
      }

      eq_or_diff \@error, $test->{errors}->[0] || [];

      done $c;
    } n => 2, name => [$path, map { $_->[0] } @{$test->{data}}];
  };
}

run_tests;

=head1 LICENSE

Copyright 2014-2017 Wakaba <wakaba@suikawiki.org>.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

require_ok( 'IroX::NLP::Engines::MITIE::Tokenizer' );

my $sentence = 'Anna has some apples, what do you have?';

my $instance = IroX::NLP::Engines::MITIE::Tokenizer->new();
my $tokens = $instance->tokenize( $sentence );

{
	no warnings 'qw';

	is_deeply(
		$tokens,
		[ qw( Anna has some apples , what do you have ? ) ],
		'Tokenizer works fine!'
	);
}

done_testing();

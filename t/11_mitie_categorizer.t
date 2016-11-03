#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

require_ok( 'IroX::NLP::Engines::MITIE::CategorizerTrainer' );
require_ok( 'IroX::NLP::Engines::MITIE::Categorizer' );

my $trainer = IroX::NLP::Engines::MITIE::CategorizerTrainer->new(
	{
		dictionary => '/opt/MITIE-models/english/total_word_feature_extractor.dat'
	}
);
isa_ok( $trainer, 'IroX::NLP::Engines::MITIE::CategorizerTrainer' );
can_ok( $trainer, qw( add_sample train ) );

$trainer->add_sample(
	'positive',
	[ qw( I am so happy and exciting to make this ) ],
);

$trainer->add_sample(
	'negative',
	[ qw( What' a black and bad day ) ],
);

my $categorizer = $trainer->train();
isa_ok( $categorizer, 'IroX::NLP::Engines::MITIE::Categorizer' );
can_ok( $categorizer, qw( categorize save ) );

my $label1 = $categorizer->categorize( [ qw( I am so happy ) ] );
isa_ok( $label1, 'IroX::NLP::Models::Label' );

is( $label1->category(), 'positive', 'Classifier works correctly!' );
ok( $label1->score() > 0, 'Scoring more than 0!' );

my $filename = sprintf( '/tmp/%s.dat', $$ );
$categorizer->save( $filename );

my $instance = IroX::NLP::Engines::MITIE::Categorizer->new( { model => $filename } );
isa_ok( $instance, 'IroX::NLP::Engines::MITIE::Categorizer' );

my $label2 = $instance->categorize( [ qw( A bad day ) ] );
isa_ok( $label2, 'IroX::NLP::Models::Label' );

is( $label2->category(), 'negative', 'Classifier works correctly, again!' );
ok( $label2->score() > 0, 'Scoring more than 0, again!' );

done_testing();

#!/user/bin/env perl

use strict;
use warnings;

use Test::More;

require_ok( 'IroX::NLP::Engines::MITIE::NameFinder' );

my $instance = IroX::NLP::Engines::MITIE::NameFinder->new(
	{
		model => '/opt/MITIE-models/english/ner_model.dat'
	}
);

isa_ok( $instance, 'IroX::NLP::Engines::MITIE::NameFinder' );
can_ok( $instance, qw( get_tags get_entities save ) );

my $entities = $instance->get_entities(
	[ qw( I met with John Becker at HBU . ) ]
);

is( scalar( @{ $entities } ), 2, 'Found the correct number of entities!' );

# use Data::Dumper;
# warn( Dumper( $entities ) );
# warn( Dumper( $instance->get_tags() ) );

done_testing();

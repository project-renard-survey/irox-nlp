#!/usr/bin/env perl

use strict;
use warnings;

use Module::Build;

my $builder = Module::Build->new(
	module_name => 'IroX::NLP',

	dist_author => 'Tudor Marghidanu',
	dist_abstract => 'NLP for IroX',

	share_dir => 'share',

	# NOTE: Keep list sorted!
	requires => {
		'Inline::Python' => undef,
		'IroX::Data' => undef,
		'Moose' => undef,
		'MooseX::AbstractFactory' => undef,
		'MooseX::AbstractMethod' => undef,
		'Test::More' => undef,
	},

	optional => { },
);

$builder->create_build_script();

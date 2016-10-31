package IroX::NLP::Models::Span {
	use Moose;

	extends 'IroX::NLP::Model';

	has 'tag' => (
		is => 'ro',
		isa => 'Str',
		required => 1,
	);

	has 'score' => (
		is => 'ro',
		isa => 'Num',
		required => 1,
	);

	has 'tokens' => (
		is => 'ro',
		isa => 'ArrayRef[Str`]',
		default => sub { [] }
	);

	has 'range' => (
		is => 'ro',
		isa => 'ArrayRef[Int]',
		default => sub { [] }
	);

	sub to_string { join( "\s", @{ shift()->tokens() } ) }

	__PACKAGE__->meta()->make_immutable();
}

1;

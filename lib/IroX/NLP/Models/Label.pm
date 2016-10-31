package IroX::NLP::Models::Label {
	use Moose;

	extends 'IroX::NLP::Model';

	has 'category' => (
		is => 'ro',
		isa => 'Str',
		required => 1,
	);

	has 'score' => (
		is => 'ro',
		isa => 'Num',
		required => 1,
	);

	__PACKAGE__->meta()->make_immutable();
}

1;

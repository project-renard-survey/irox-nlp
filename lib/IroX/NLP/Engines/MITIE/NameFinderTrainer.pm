package IroX::NLP::Engines::MITIE::NameFinderTrainer {
	use Moose;

	use Inline Python => 'from mitie import ner_trainer';

	use IroX::NLP::Engines::MITIE::NameFinder;

	has 'dictionary' => (
		is => 'ro',
		isa => 'Str',
		required => 1,
	);

	has '_trainer' => (
		is => 'ro',
		isa => 'Inline::Python::Object',
		lazy => 1,
		default => sub {
			IroX::NLP::Engines::MITIE::NameFinderTrainer::ner_trainer->new(
				shift()->dictionary()
			)
		}
	);

	sub add_entity {
		# TODO: Implement this!
	}

	sub train {
		my $self = shift();

		my $ner = $self->_trainer()
			->train();

		return IroX::NLP::Engines::MITIE::NameFinder->new( { _ner => $ner } );
	}

	__PACKAGE__->meta()->make_immutable();
}

1;

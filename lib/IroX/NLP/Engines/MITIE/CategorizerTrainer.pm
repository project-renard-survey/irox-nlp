package IroX::NLP::Engines::MITIE::CategorizerTrainer {
	use Moose;

	use Inline Python => 'from mitie import text_categorizer_trainer';

	use IroX::NLP::Engines::MITIE::Categorizer;

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
			IroX::NLP::Engines::MITIE::CategorizerTrainer::text_categorizer_trainer->new(
				shift()->dictionary()
			);
		}
	);

	sub add_sample {
		my ( $self, $category, $tokens ) = @_;

		$self->_trainer()
			->add_labeled_text( $tokens, $category );
	}

	sub train {
		my $self = shift();

		my $categorizer = $self->_trainer()
			->train();

		return IroX::NLP::Engines::MITIE::Categorizer->new( { _categorizer => $categorizer } );
	}

	__PACKAGE__->meta()->make_immutable();
}

1;

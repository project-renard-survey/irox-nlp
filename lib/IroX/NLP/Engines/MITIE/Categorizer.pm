package IroX::NLP::Engines::MITIE::Categorizer {
	use Moose;

	use Inline Python => 'from mitie import text_categorizer';

	use IroX::NLP::Models::Label ;

	has 'models' => (
		is => 'ro',
		isa => 'ArrayRef[Str]',
		traits => [ qw( Array ) ],
		handles => {
			all_models => 'elements',
		}
	);

	has '_categorizer' => (
		is => 'ro',
		isa => 'Inline::Python::Object',
		lazy => 1,
		default => sub {
			IroX::NLP::Engines::MITIE::Categorizer::text_categorizer->new(
				shift()->all_models()
			);
		}
	);

	sub categorize {
		my ( $self, $tokens ) = @_;

		my ( $category, $score ) = $self->_categorizer()
			->__call__( $tokens );

		return IroX::NLP::Models::Label->new(
			{
				category => $category,
				score => $score
			}
		)
	}

	sub save {
		my ( $self, $filename ) = @_;

		$self->_categorizer()
			->save_to_disk(
				$filename,
				$Inline::Python::Boolean::true
			);
	}

	__PACKAGE__->meta()->make_immutable();
}

1;

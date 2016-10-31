package IroX::NLP::Engines::MITIE::NameFinder {
	use Moose;

	use Inline Python => 'from mitie import named_entity_extractor';

	use IroX::NLP::Models::Span;

	has 'model' => (
		is => 'ro',
		isa => 'Str',
		required => 1,
	);

	has '_ner' => (
		is => 'ro',
		isa => 'Inline::Python::Object',
		lazy => 1,
		default => sub {
			IroX::NLP::Engines::MITIE::NameFinder::named_entity_extractor->new(
				shift()->model()
			);
		}
	);

	sub get_tags {
		my $self = shift();

		return $self->_ner()
			->get_possible_tags();
	}

	sub get_entities {
		my ( $self, $tokens ) = @_;

		my $entities = $self->_ner()
			->extract_entities( $tokens );

		return [
			map {
				IroX::NLP::Models::Span->new(
					{
						tag => $_->[1],
						score => $_->[2],
						tokens => @$tokens[ @{ $_->[0] } ],
						range => $_->[0],
					}
				)
			} @{ $entities }
		];
	}

	sub save {
		my ( $self, $filename ) = @_;

		$self->_ner()
			->save_to_disk( $filename );
	}

	__PACKAGE__->meta()->make_immutable();
}

1;

package IroX::NLP::Engines::MITIE::Tokenizer {
	use Moose;

	use Inline Python => 'from mitie import tokenize';

	around 'tokenize' => sub {
		my $orig = shift();
		my $self = shift();

		my $result = $orig->( @_ );

		return $result;
	};

	__PACKAGE__->meta()->make_immutable();
}

1;

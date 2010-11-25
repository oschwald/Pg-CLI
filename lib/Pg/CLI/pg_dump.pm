package Pg::CLI::pg_dump;

use Moose;

use namespace::autoclean;

use MooseX::Params::Validate qw( validated_list );
use MooseX::SemiAffordanceAccessor;
use MooseX::Types::Moose qw( ArrayRef Bool Str );

with 'Pg::CLI::Role::Command';

sub run {
    my $self = shift;
    my ( $database, $options ) = validated_list(
        \@_,
        database => { isa => Str },
        options  => { isa => ArrayRef [Str], default => [] },
    );

    $self->_execute_command(
        'pg_dump',
        $self->_connect_options(),
        @{$options},
        $database,
    );
}

__PACKAGE__->meta()->make_immutable();

1;

# ABSTRACT: Wrapper for the F<pg_dump> utility

__END__

=head1 SYNOPSIS

  my $pg_dump = Pg::CLI::pg_dump->new(
      username => 'foo',
      password => 'bar',
      host     => 'pg.example.com',
      port     => 5433,
  );

  $pg_dump->run(
      database => 'database',
      options  => [ '-C' ],
  );

=head1 DESCRIPTION

This class provides a wrapper for the F<pg_dump> utility.

=head1 METHODS

This class provides the following methods:

=head2 Pg::CLI::pg_dump->new( ... )

The constructor accepts a number of parameters:

=over 4

=item * username

The username to use when connecting to the database. Optional.

=item * password

The password to use when connecting to the database. Optional.

=item * host

The host to use when connecting to the database. Optional.

=item * port

The port to use when connecting to the database. Optional.

=item * quiet

This defaults to true. When true, the "-q" flag is passed to pg_dump whenever it
is executed.

=back

=head2 $pg_dump->run( database => ..., options => [ ... ] )

This method dumps the specified database. Any values passed in C<options> will
be passed on to pg_dump.

=head1 BUGS

See L<Pg::CLI> for bug reporting details.

=cut


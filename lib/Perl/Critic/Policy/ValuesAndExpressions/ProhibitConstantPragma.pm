##############################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/tags/Perl-Critic-1.053/lib/Perl/Critic/Policy/ValuesAndExpressions/ProhibitConstantPragma.pm $
#     $Date: 2007-06-03 13:16:10 -0700 (Sun, 03 Jun 2007) $
#   $Author: thaljef $
# $Revision: 1578 $
##############################################################################

package Perl::Critic::Policy::ValuesAndExpressions::ProhibitConstantPragma;

use strict;
use warnings;
use Perl::Critic::Utils qw{ :severities };
use base 'Perl::Critic::Policy';

our $VERSION = 1.053;

#-----------------------------------------------------------------------------

my $desc = q{Pragma "constant" used};
my $expl = [ 55 ];

#-----------------------------------------------------------------------------

sub supported_parameters { return() }
sub default_severity { return $SEVERITY_HIGH            }
sub default_themes    { return qw( core bugs pbp )           }
sub applies_to       { return 'PPI::Statement::Include' }

#-----------------------------------------------------------------------------

sub violates {
    my ( $self, $elem, undef ) = @_;
    if ( $elem->type() eq 'use' && $elem->pragma() eq 'constant' ) {
        return $self->violation( $desc, $expl, $elem );
    }
    return;    #ok!
}

1;

__END__

#-----------------------------------------------------------------------------

=pod

=head1 NAME

Perl::Critic::Policy::ValuesAndExpressions::ProhibitConstantPragma

=head1 DESCRIPTION

Named constants are a good thing.  But don't use the C<constant>
pragma because barewords don't interpolate.  Instead use the
L<Readonly> module.

  use constant FOOBAR => 42;  #not ok

  use Readonly;
  Readonly  my $FOOBAR => 42;  #ok

=head1 AUTHOR

Jeffrey Ryan Thalhammer <thaljef@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2005-2007 Jeffrey Ryan Thalhammer.  All rights reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.  The full text of this license
can be found in the LICENSE file included with this module.

=cut

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 78
#   indent-tabs-mode: nil
#   c-indentation-style: bsd
# End:
# ex: set ts=8 sts=4 sw=4 tw=78 ft=perl expandtab :

##############################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/tags/Perl-Critic-1.03/lib/Perl/Critic/Policy/NamingConventions/ProhibitMixedCaseSubs.pm $
#     $Date: 2007-02-13 10:58:53 -0800 (Tue, 13 Feb 2007) $
#   $Author: thaljef $
# $Revision: 1247 $
##############################################################################

package Perl::Critic::Policy::NamingConventions::ProhibitMixedCaseSubs;

use strict;
use warnings;
use Perl::Critic::Utils qw{ :severities };
use base 'Perl::Critic::Policy';

our $VERSION = 1.03;

#-----------------------------------------------------------------------------

my $mixed_rx = qr/ [A-Z][a-z] | [a-z][A-Z] /x;
my $desc     = 'Mixed-case subroutine name';
my $expl     = [ 44 ];

#-----------------------------------------------------------------------------

sub supported_parameters { return() }
sub default_severity { return $SEVERITY_LOWEST      }
sub default_themes    { return qw( core pbp cosmetic )    }
sub applies_to       { return 'PPI::Statement::Sub' }

#-----------------------------------------------------------------------------

sub violates {
    my ( $self, $elem, undef ) = @_;
    (my $name = $elem->name() ) =~ s/\A.*:://mx;
    if ( $name =~ $mixed_rx ) {
        return $self->violation( $desc, $expl, $elem );
    }
    return;    #ok!
}

1;

__END__

#-----------------------------------------------------------------------------

=pod

=head1 NAME

Perl::Critic::Policy::NamingConventions::ProhibitMixedCaseSubs

=head1 DESCRIPTION

Conway's recommended naming convention is to use lower-case words
separated by underscores.  Well-recognized acronyms can be in ALL
CAPS, but must be separated by underscores from other parts of the
name.

  sub foo_bar{}   #ok
  sub foo_BAR{}   #ok
  sub FOO_bar{}   #ok
  sub FOO_BAR{}   #ok

  sub Some::Class::foo{}   #ok, grudgingly

  sub FooBar {}   #not ok
  sub FOObar {}   #not ok
  sub fooBAR {}   #not ok
  sub fooBar {}   #not ok

=head1 SEE ALSO

L<Perl::Critic::Policy::NamingConventions::ProhibitMixedCaseVars>

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

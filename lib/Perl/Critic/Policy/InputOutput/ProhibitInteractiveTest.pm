##############################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/trunk/Perl-Critic/lib/Perl/Critic/Policy/InputOutput/ProhibitInteractiveTest.pm $
#     $Date: 2008-05-18 18:49:57 -0500 (Sun, 18 May 2008) $
#   $Author: clonezone $
# $Revision: 2367 $
##############################################################################

package Perl::Critic::Policy::InputOutput::ProhibitInteractiveTest;

use strict;
use warnings;
use Readonly;

use Perl::Critic::Utils qw{ :severities };
use base 'Perl::Critic::Policy';

our $VERSION = '1.083_004';

#-----------------------------------------------------------------------------

Readonly::Scalar my $DESC => q{Use IO::Interactive::is_interactive() instead of -t};
Readonly::Scalar my $EXPL => [ 218 ];

#-----------------------------------------------------------------------------

sub supported_parameters { return ()                     }
sub default_severity     { return $SEVERITY_HIGHEST      }
sub default_themes       { return qw( core pbp bugs )    }
sub applies_to           { return 'PPI::Token::Operator' }

#-----------------------------------------------------------------------------

sub violates {
    my ($self, $elem, $doc) = @_;
    return if $elem ne '-t';
    return $self->violation( $DESC, $EXPL, $elem );
}

1;

#-----------------------------------------------------------------------------

__END__

=pod

=head1 NAME

Perl::Critic::Policy::InputOutput::ProhibitInteractiveTest - Use prompt() instead of -t.

=head1 AFFILIATION

This Policy is part of the core L<Perl::Critic> distribution.


=head1 DESCRIPTION

The C<-t> operator is fragile and complicated.  When you are testing
whether C<STDIN> is interactive, It's much more robust to use
well-tested CPAN modules like L<IO::Interactive>.


=head1 CONFIGURATION

This Policy is not configurable except for the standard options.


=head1 AUTHOR

Chris Dolan <cdolan@cpan.org>

=head1 COPYRIGHT

Copyright (C) 2006 Chris Dolan.  All rights reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 78
#   indent-tabs-mode: nil
#   c-indentation-style: bsd
# End:
# ex: set ts=8 sts=4 sw=4 tw=78 ft=perl expandtab shiftround :

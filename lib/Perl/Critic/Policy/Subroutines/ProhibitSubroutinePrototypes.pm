#######################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/tags/Perl-Critic-0.21/lib/Perl/Critic/Policy/Subroutines/ProhibitSubroutinePrototypes.pm $
#     $Date: 2006-11-05 18:01:38 -0800 (Sun, 05 Nov 2006) $
#   $Author: thaljef $
# $Revision: 809 $
# ex: set ts=8 sts=4 sw=4 expandtab
########################################################################

package Perl::Critic::Policy::Subroutines::ProhibitSubroutinePrototypes;

use strict;
use warnings;
use Perl::Critic::Utils;
use base 'Perl::Critic::Policy';

our $VERSION = 0.21;

#---------------------------------------------------------------------------

my $desc = q{Subroutine prototypes used};
my $expl = [ 194 ];

#---------------------------------------------------------------------------

sub default_severity { return $SEVERITY_HIGHEST     }
sub default_themes    { return qw(pbp danger)        }
sub applies_to       { return 'PPI::Statement::Sub' }

#---------------------------------------------------------------------------

sub violates {
    my ( $self, $elem, undef ) = @_;
    if ( $elem->prototype() ) {
        return $self->violation( $desc, $expl, $elem );
    }
    return;    #ok!
}

1;

__END__

#---------------------------------------------------------------------------

=pod

=head1 NAME

Perl::Critic::Policy::Subroutines::ProhibitSubroutinePrototypes

=head1 DESCRIPTION

Contrary to common belief, subroutine prototypes do not enable
compile-time checks for proper arguments.  Don't use them.

=head1 AUTHOR

Jeffrey Ryan Thalhammer <thaljef@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2005-2006 Jeffrey Ryan Thalhammer.  All rights reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.  The full text of this license
can be found in the LICENSE file included with this module.

=cut

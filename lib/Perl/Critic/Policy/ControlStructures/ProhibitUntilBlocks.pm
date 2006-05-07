#######################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/trunk/Perl-Critic/lib/Perl/Critic/Policy/ControlStructures/ProhibitUntilBlocks.pm $
#     $Date: 2006-04-28 23:36:18 -0700 (Fri, 28 Apr 2006) $
#   $Author: thaljef $
# $Revision: 396 $
########################################################################

package Perl::Critic::Policy::ControlStructures::ProhibitUntilBlocks;

use strict;
use warnings;
use Perl::Critic::Violation;
use Perl::Critic::Utils;
use base 'Perl::Critic::Policy';

our $VERSION = '0.15_03';
$VERSION = eval $VERSION;    ## no critic

#----------------------------------------------------------------------------

my $desc = q{'until' block used};
my $expl = [ 97 ];

#----------------------------------------------------------------------------

sub default_severity { return $SEVERITY_LOW }
sub applies_to { return 'PPI::Statement' }

#----------------------------------------------------------------------------

sub violates {
    my ( $self, $elem, $doc ) = @_;
    if ( $elem->first_element() eq 'until' ) {
        my $sev = $self->get_severity();
        return Perl::Critic::Violation->new( $desc, $expl, $elem, $sev );
    }
    return;    #ok!
}

1;

__END__

#----------------------------------------------------------------------------

=pod

=head1 NAME

Perl::Critic::Policy::ControlStructures::ProhibitUntilBlocks

=head1 DESCRIPTION

Conway discourages using C<until> because it leads to double-negatives
that are hard to understand.  Instead, reverse the logic and use C<while>.

  until($condition)     { do_something() } #not ok
  until(! $no_flag)     { do_something() } #really bad
  while( ! $condition)  { do_something() } #ok

This Policy only covers the block-form of C<until>.  For the postfix
variety, see C<ProhibitPostfixControls>.

=head1 SEE ALSO

L<Perl::Critic::Policy::ControlStructures::ProhibitPostfixControls>

=head1 AUTHOR

Jeffrey Ryan Thalhammer <thaljef@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2005-2006 Jeffrey Ryan Thalhammer.  All rights reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.  The full text of this license
can be found in the LICENSE file included with this module.

=cut

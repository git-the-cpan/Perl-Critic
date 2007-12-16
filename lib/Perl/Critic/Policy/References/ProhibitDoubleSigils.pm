##############################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/trunk/Perl-Critic/lib/Perl/Critic/Policy/References/ProhibitDoubleSigils.pm $
#     $Date: 2007-12-16 13:14:12 -0600 (Sun, 16 Dec 2007) $
#   $Author: clonezone $
# $Revision: 2047 $
##############################################################################

package Perl::Critic::Policy::References::ProhibitDoubleSigils;

use strict;
use warnings;
use Readonly;

use Perl::Critic::Utils qw{ :severities };
use base 'Perl::Critic::Policy';

our $VERSION = '1.081_002';

#-----------------------------------------------------------------------------

Readonly::Scalar my $DESC => q{Double-sigil dereference};
Readonly::Scalar my $EXPL => [ 228 ];

#-----------------------------------------------------------------------------

sub supported_parameters { return ()                    }
sub default_severity     { return $SEVERITY_LOW         }
sub default_themes       { return qw(core pbp cosmetic) }
sub applies_to           { return 'PPI::Token::Cast'    }

#-----------------------------------------------------------------------------

sub violates {
    my ( $self, $elem, undef ) = @_;
    return if $elem eq q{\\};

    my $sib = $elem->snext_sibling;
    return if !$sib;
    if ( ! $sib->isa('PPI::Structure::Block') ) {
        return $self->violation( $DESC, $EXPL, $elem );
    }
    return; #ok!
}

1;

__END__

#-----------------------------------------------------------------------------

=pod

=head1 NAME

Perl::Critic::Policy::References::ProhibitDoubleSigils

=head1 DESCRIPTION

When dereferencing a reference, put braces around the reference to
separate the sigils.  Especially for newbies, the braces eliminate any
potential confusion about the relative precedence of the sigils.

  push @$array_ref, 'foo', 'bar', 'baz';      #not ok
  push @{ $array_ref }, 'foo', 'bar', 'baz';  #ok

  foreach ( keys %$hash_ref ){}               #not ok
  foreach ( keys %{ $hash_ref } ){}           #ok

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

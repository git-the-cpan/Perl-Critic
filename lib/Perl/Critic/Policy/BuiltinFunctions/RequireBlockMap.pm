##############################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/tags/Perl-Critic-1.051/lib/Perl/Critic/Policy/BuiltinFunctions/RequireBlockMap.pm $
#     $Date: 2007-04-12 01:26:09 -0700 (Thu, 12 Apr 2007) $
#   $Author: thaljef $
# $Revision: 1467 $
##############################################################################

package Perl::Critic::Policy::BuiltinFunctions::RequireBlockMap;

use strict;
use warnings;
use Perl::Critic::Utils qw{ :severities :classification :ppi };
use base 'Perl::Critic::Policy';

our $VERSION = 1.051;

#-----------------------------------------------------------------------------

my $desc = q{Expression form of "map"};
my $expl = [ 169 ];

#-----------------------------------------------------------------------------

sub supported_parameters { return() }
sub default_severity { return $SEVERITY_HIGH     }
sub default_themes    { return qw( core bugs pbp )    }
sub applies_to       { return 'PPI::Token::Word' }

#-----------------------------------------------------------------------------

sub violates {
    my ( $self, $elem, undef ) = @_;

    return if $elem ne 'map';
    return if ! is_function_call($elem);

    my $arg = first_arg($elem);
    return if !$arg;
    return if $arg->isa('PPI::Structure::Block');

    return $self->violation( $desc, $expl, $elem );
}

1;

__END__

#-----------------------------------------------------------------------------

=pod

=head1 NAME

Perl::Critic::Policy::BuiltinFunctions::RequireBlockMap

=head1 DESCRIPTION

The expression forms of C<grep> and C<map> are awkward and hard to read.
Use the block forms instead.

  @matches = grep   /pattern/,   @list;        #not ok
  @matches = grep { /pattern/ }  @list;        #ok

  @mapped = map   transform($_),   @list;      #not ok
  @mapped = map { transform($_) }  @list;      #ok


=head1 SEE ALSO

L<Perl::Critic::Policy::BuiltinFunctions::ProhibitStringyEval>

L<Perl::Critic::Policy::BuiltinFunctions::RequireBlockGrep>

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

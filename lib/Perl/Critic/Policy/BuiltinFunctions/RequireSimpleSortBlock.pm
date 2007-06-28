##############################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/tags/Perl-Critic-1.06/lib/Perl/Critic/Policy/BuiltinFunctions/RequireSimpleSortBlock.pm $
#     $Date: 2007-06-27 23:50:20 -0700 (Wed, 27 Jun 2007) $
#   $Author: thaljef $
# $Revision: 1709 $
##############################################################################

package Perl::Critic::Policy::BuiltinFunctions::RequireSimpleSortBlock;

use strict;
use warnings;
use Perl::Critic::Utils qw{ :severities :classification };
use base 'Perl::Critic::Policy';

our $VERSION = 1.06;

#-----------------------------------------------------------------------------

my $desc = q{Sort blocks should have a single statement};
my $expl = [ 149 ];

#-----------------------------------------------------------------------------

sub supported_parameters { return ()                                   }
sub default_severity  { return $SEVERITY_MEDIUM                     }
sub default_themes    { return qw( core pbp maintenance complexity) }
sub applies_to        { return 'PPI::Token::Word'                   }

#-----------------------------------------------------------------------------

sub violates {
    my ( $self, $elem, undef ) = @_;

    return if $elem ne 'sort';
    return if ! is_function_call($elem);

    my $sib = $elem->snext_sibling();
    return if !$sib;

    my $arg = $sib;
    if ( $arg->isa('PPI::Structure::List') ) {
        $arg = $arg->schild(0);
        # Forward looking: PPI might change in v1.200 so schild(0) is a PPI::Statement::Expression
        if ( $arg && $arg->isa('PPI::Statement::Expression') ) {
            $arg = $arg->schild(0);
        }
    }
    return if !$arg || !$arg->isa('PPI::Structure::Block');

    # If we get here, we found a sort with a block as the first arg
    return if ( 1 >= $arg->schildren() );

    # more than one child statements
    return $self->violation( $desc, $expl, $elem );
}

1;

#-----------------------------------------------------------------------------

__END__

=pod

=head1 NAME

Perl::Critic::Policy::BuiltinFunctions::RequireSimpleSortBlock

=head1 DESCRIPTION

Conway advises that sort functions should be simple.  Any complicated
operations on list elements should be computed and cached (perhaps via
a Schwartzian Transform) before the sort, rather than computed inside
the sort block, because the sort block is called C<N log N> times
instead of just C<N> times.

This policy prohibits the most blatant case of complicated sort
blocks: multiple statements.  Future policies may wish to examine the
sort block in more detail -- looking for subroutine calls or large
numbers of operations.

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
# ex: set ts=8 sts=4 sw=4 tw=78 ft=perl expandtab :

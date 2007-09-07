##############################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/branches/Perl-Critic-1.073/lib/Perl/Critic/Policy/ValuesAndExpressions/ProhibitLongChainsOfMethodCalls.pm $
#     $Date: 2007-09-07 17:29:56 -0500 (Fri, 07 Sep 2007) $
#   $Author: clonezone $
# $Revision: 1890 $
##############################################################################

package Perl::Critic::Policy::ValuesAndExpressions::ProhibitLongChainsOfMethodCalls;

use strict;
use warnings;

use Perl::Critic::Utils qw{ :booleans :characters :severities };
use Perl::Critic::Utils::PPI qw{ is_ppi_expression_or_generic_statement };
use base 'Perl::Critic::Policy';

our $VERSION = 1.076;

#-----------------------------------------------------------------------------

my $EXPL =
    q{Long chains of method calls indicate code that is too tightly coupled};

#-----------------------------------------------------------------------------

my $DEFAULT_MAX_CHAIN_LENGTH = 3;

sub supported_parameters {
    return qw{ max_chain_length };
}

sub default_severity { return $SEVERITY_LOW          }
sub default_themes   { return qw( core maintenance ) }
sub applies_to       { return qw{ PPI::Statement };  }

#-----------------------------------------------------------------------------

sub initialize_if_enabled {
    my ($self, $config) = @_;

    my $max_chain_length = $config->{max_chain_length};
    if (
            not $max_chain_length
        or  $max_chain_length !~ m/ \A \d+ \z /xms
        or  $max_chain_length < 1
    ) {
        $max_chain_length = $DEFAULT_MAX_CHAIN_LENGTH;
    }

    $self->{_max_chain_length} = $max_chain_length;

    return $TRUE;
}

#-----------------------------------------------------------------------------

sub _max_chain_length {
    my ( $self ) = @_;

    return $self->{_max_chain_length};
}

#-----------------------------------------------------------------------------

sub violates {
    my ( $self, $elem, undef ) = @_;

    return if not is_ppi_expression_or_generic_statement($elem);

    my $chain_length = 0;
    my $max_chain_length = $self->_max_chain_length();
    my @children = $elem->schildren();
    my $child = shift @children;

    while ($child) {
        # if it looks like we've got a subroutine call, drop the parameter
        # list.
        if (
                $child->isa('PPI::Token::Word')
            and @children
            and $children[0]->isa('PPI::Structure::List')
        ) {
            shift @children;
        }

        if (
                $child->isa('PPI::Token::Word')
            or  $child->isa('PPI::Token::Symbol')
        ) {
            if (
                    @children
                and $children[0]->isa('PPI::Token::Operator')
                and q{->} eq $children[0]->content()
            ) {
                $chain_length++;
                shift @children;
            }
        }
        else {
            if ($chain_length > $max_chain_length) {
                return
                    $self->violation(
                        "Found method-call chain of length $chain_length.",
                        $EXPL,
                        $elem,
                    );
            }

            $chain_length = 0;
        }

        $child = shift @children;
    }

    if ($chain_length > $max_chain_length) {
        return
            $self->violation(
                "Found method-call chain of length $chain_length.",
                $EXPL,
                $elem,
            );
    }

    return;
}


1;

__END__

#-----------------------------------------------------------------------------

=pod

=for stopwords MSCHWERN

=head1 NAME

Perl::Critic::Policy::ValuesAndExpressions::ProhibitLongChainsOfMethodCalls


=head1 DESCRIPTION

A long chain of method calls usually indicates that the code knows too
much about the interrelationships between objects.  If the code is
able to directly navigate far down a network of objects, then when the
network changes structure in the future, the code will need to be
modified to deal with the change.  The code is too tightly coupled and
is brittle.


  $x = $y->a;           #ok
  $x = $y->a->b;        #ok
  $x = $y->a->b->c;     #questionable, but allowed by default
  $x = $y->a->b->c->d;  #not ok


=head1 CONFIGURATION

This policy has one option: C<max_chain_length> which controls how far
the code is allowed to navigate.  The default value is 3.


=head1 AUTHOR

Elliot Shank C<< <perl@galumph.com> >>


=head1 COPYRIGHT

Copyright (c) 2007 Elliot Shank.  All rights reserved.

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

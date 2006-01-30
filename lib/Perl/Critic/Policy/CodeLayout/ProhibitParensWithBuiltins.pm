#######################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/trunk/Perl-Critic/lib/Perl/Critic/Policy/CodeLayout/ProhibitParensWithBuiltins.pm $
#     $Date: 2006-01-04 20:29:14 -0800 (Wed, 04 Jan 2006) $
#   $Author: thaljef $
# $Revision: 209 $
########################################################################

package Perl::Critic::Policy::CodeLayout::ProhibitParensWithBuiltins;

use strict;
use warnings;
use Perl::Critic::Utils;
use Perl::Critic::Violation;
use List::MoreUtils qw(any);
use base 'Perl::Critic::Policy';

our $VERSION = '0.14';
$VERSION = eval $VERSION;    ## no critic

#----------------------------------------------------------------------------

my %allow = ( my => 1, our => 1, local => 1, return => 1, );
my $desc  = q{Builtin function called with parens};
my $expl  = [ 13 ];

#----------------------------------------------------------------------------

sub default_severity { return $SEVERITY_LOWEST }
sub applies_to { return 'PPI::Token::Word' }

#----------------------------------------------------------------------------

sub violates {
    my ( $self, $elem, $doc ) = @_;
    return if exists $allow{"$elem"};
    if ( any { $elem eq $_ } @BUILTINS ) {
        if ( _sibling_is_list($elem) && ! _is_object_method($elem) ) {
            my $sev = $self->get_severity();
            return Perl::Critic::Violation->new( $desc, $expl, $elem, $sev );
        }
    }
    return;    #ok!
}

sub _sibling_is_list {
    my $elem = shift;
    my $sib = $elem->snext_sibling() || return;
    return $sib->isa('PPI::Structure::List');
}

sub _is_object_method {
    my $elem = shift;
    my $sib = $elem->sprevious_sibling() || return;
    return $sib->isa('PPI::Token::Operator') && $sib eq q{->};
}

1;

__END__

=pod

=head1 NAME

Perl::Critic::Policy::CodeLayout::ProhibitParensWithBuiltins

=head1 DESCRIPTION

Conway suggests that all built-in functions should be called without
parenthesis around the argument list.  This reduces visual clutter and
disambiguates built-in functions from user functions.  Exceptions are
made for C<my>, C<local>, and C<our> which require parenthesis when
called with multiple arguments.  C<return> is also exempt because
technically it is a named unary operator, not a function.

  open($handle, '>', $filename); #not ok
  open $handle, '>', $filename;  #ok 

  split(/$pattern/, @list); #not ok
  split /$pattern/, @list;  #ok

=head1 AUTHOR

Jeffrey Ryan Thalhammer <thaljef@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2005-2006 Jeffrey Ryan Thalhammer.  All rights reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.  The full text of this license
can be found in the LICENSE file included with this module.

=cut

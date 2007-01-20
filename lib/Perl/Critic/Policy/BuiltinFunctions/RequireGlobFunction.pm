##############################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/trunk/Perl-Critic/lib/Perl/Critic/Policy/BuiltinFunctions/RequireGlobFunction.pm $
#     $Date: 2007-01-19 23:02:33 -0800 (Fri, 19 Jan 2007) $
#   $Author: thaljef $
# $Revision: 1162 $
##############################################################################

package Perl::Critic::Policy::BuiltinFunctions::RequireGlobFunction;

use strict;
use warnings;
use Perl::Critic::Utils;
use base 'Perl::Critic::Policy';

our $VERSION = 0.23;

#-----------------------------------------------------------------------------

my $glob_rx = qr{ [\*\?] }x;
my $desc    = q{Glob written as <...>};
my $expl    = [ 167 ];

#-----------------------------------------------------------------------------

sub supported_parameters { return() }
sub default_severity { return $SEVERITY_HIGHEST }
sub default_themes    { return qw( core pbp bugs )  }
sub applies_to       { return 'PPI::Token::QuoteLike::Readline' }

#-----------------------------------------------------------------------------

sub violates {
    my ( $self, $elem, undef ) = @_;

    if ( $elem =~ $glob_rx ) {
        return $self->violation( $desc, $expl, $elem );
    }
    return;    #ok!
}

1;

__END__

#-----------------------------------------------------------------------------

=pod

=head1 NAME

Perl::Critic::Policy::BuiltinFunctions::RequireGlobFunction

=head1 DESCRIPTION

Conway discourages the use of the C< <..> > construct for globbing, as
it is easily confused with the angle bracket file input operator.
Instead, he recommends the use of the C<glob()> function as it makes
it much more obvious what you're attempting to do.

  @files = <*.pl>;              # not ok
  @files = glob( "*.pl" );      # ok

=head1 AUTHOR

Graham TerMarsch <graham@howlingfrog.com>

=head1 COPYRIGHT

Copyright (C) 2005-2007 Graham TerMarsch.  All rights reserved.

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

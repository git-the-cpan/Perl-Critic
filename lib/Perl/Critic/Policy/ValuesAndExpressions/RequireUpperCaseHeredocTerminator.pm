##############################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/tags/Perl-Critic-1.04/lib/Perl/Critic/Policy/ValuesAndExpressions/RequireUpperCaseHeredocTerminator.pm $
#     $Date: 2007-03-19 18:06:56 -0800 (Mon, 19 Mar 2007) $
#   $Author: thaljef $
# $Revision: 1308 $
##############################################################################

package Perl::Critic::Policy::ValuesAndExpressions::RequireUpperCaseHeredocTerminator;

use strict;
use warnings;
use Perl::Critic::Utils qw{ :severities };
use base 'Perl::Critic::Policy';

our $VERSION = 1.04;

#-----------------------------------------------------------------------------

my $heredoc_rx = qr{ \A << ["|']? [A-Z_] [A-Z0-9_]* ['|"]? \z }x;
my $desc       = q{Heredoc terminator not alphanumeric and upper-case};
my $expl       = [ 64 ];

#-----------------------------------------------------------------------------

sub supported_parameters { return() }
sub default_severity { return $SEVERITY_LOW         }
sub default_themes   { return qw(core pbp cosmetic)   }
sub applies_to       { return 'PPI::Token::HereDoc' }

#-----------------------------------------------------------------------------

sub violates {
    my ( $self, $elem, undef ) = @_;

    if ( $elem !~ $heredoc_rx ) {
        return $self->violation( $desc, $expl, $elem );
    }
    return;    #ok!
}

1;

__END__

#-----------------------------------------------------------------------------

=pod

=head1 NAME

Perl::Critic::Policy::ValuesAndExpressions::RequireUpperCaseHeredocTerminator

=head1 DESCRIPTION

For legibility, HEREDOC terminators should be all UPPER CASE letters
(and numbers), without any whitespace.  Conway also recommends using a
standard prefix like "END_" but this policy doesn't enforce that.

  print <<'the End';  #not ok
  Hello World
  the End

  print <<'THE_END';  #ok
  Hello World
  THE_END

=head1 SEE ALSO

L<Perl::Critic::Policy::ValuesAndExpressions::RequireQuotedHeredocTerminator>

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

##############################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/trunk/distributions/Perl-Critic/lib/Perl/Critic/Policy/InputOutput/ProhibitReadlineInForLoop.pm $
#     $Date: 2009-06-27 20:02:58 -0400 (Sat, 27 Jun 2009) $
#   $Author: clonezone $
# $Revision: 3373 $
##############################################################################

package Perl::Critic::Policy::InputOutput::ProhibitReadlineInForLoop;

use 5.006001;
use strict;
use warnings;
use Readonly;

use Perl::Critic::Utils qw{ :severities };
use base 'Perl::Critic::Policy';

our $VERSION = '1.099_002';

#-----------------------------------------------------------------------------

Readonly::Scalar my $DESC => q{Readline inside "for" loop};
Readonly::Scalar my $EXPL => [ 211 ];

#-----------------------------------------------------------------------------

sub supported_parameters { return ()                           }
sub default_severity     { return $SEVERITY_HIGH               }
sub default_themes       { return qw( core bugs pbp )          }
sub applies_to           { return qw( PPI::Structure::ForLoop) }

#-----------------------------------------------------------------------------

sub violates {
    my ( $self, $elem, undef ) = @_;

    if ( my $rl = $elem->find_first('PPI::Token::QuoteLike::Readline') ) {
        return $self->violation( $DESC, $EXPL, $rl );
    }

    return;  #ok!
}

1;

__END__

#-----------------------------------------------------------------------------

=pod

=head1 NAME

Perl::Critic::Policy::InputOutput::ProhibitReadlineInForLoop - Write C<< while( $line = <> ){...} >> instead of C<< for(<>){...} >>.

=head1 AFFILIATION

This Policy is part of the core L<Perl::Critic|Perl::Critic>
distribution.


=head1 DESCRIPTION

Using the readline operator in a C<for> or C<foreach> loop is very
slow.  The iteration list of the loop creates a list context, which
causes the readline operator to read the entire input stream before
iteration even starts.  Instead, just use a C<while> loop, which only
reads one line at a time.

  for my $line ( <$file_handle> ){ do_something($line) }      #not ok
  while ( my $line = <$file_handle> ){ do_something($line) }  #ok


=head1 CONFIGURATION

This Policy is not configurable except for the standard options.


=head1 AUTHOR

Jeffrey Ryan Thalhammer <thaljef@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2005-2009 Jeffrey Ryan Thalhammer.  All rights reserved.

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
# ex: set ts=8 sts=4 sw=4 tw=78 ft=perl expandtab shiftround :

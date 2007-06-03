##############################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/tags/Perl-Critic-1.053/lib/Perl/Critic/Policy/BuiltinFunctions/ProhibitSleepViaSelect.pm $
#     $Date: 2007-06-03 13:16:10 -0700 (Sun, 03 Jun 2007) $
#   $Author: thaljef $
# $Revision: 1578 $
##############################################################################

package Perl::Critic::Policy::BuiltinFunctions::ProhibitSleepViaSelect;

use strict;
use warnings;
use Perl::Critic::Utils qw{ :severities :classification :ppi };
use base 'Perl::Critic::Policy';

our $VERSION = 1.053;

#-----------------------------------------------------------------------------

my $desc = q{"select" used to emulate "sleep"};
my $expl = [168];

#-----------------------------------------------------------------------------

sub supported_parameters { return() }
sub default_severity { return $SEVERITY_HIGHEST  }
sub default_themes    { return qw( core pbp bugs )   }
sub applies_to       { return 'PPI::Token::Word' }

#-----------------------------------------------------------------------------

sub violates {
    my ($self, $elem, undef) = @_;

    return if ($elem ne 'select');
    return if ! is_function_call($elem);

    if ( 3 == grep {$_->[0] eq 'undef' } parse_arg_list($elem) ){
        return $self->violation( $desc, $expl, $elem );
    }
    return; #ok!
}

1;

__END__

#-----------------------------------------------------------------------------

=pod

=head1 NAME

Perl::Critic::Policy::BuiltinFunctions::ProhibitSleepViaSelect

=head1 DESCRIPTION

Conway discourages the use of C<select()> for performing non-integer
sleeps.  Although documented in L<perlfunc>, it's something that
generally requires the reader to read C<perldoc -f select> to figure out what it should be
doing.  Instead, Conway recommends that you use the
C<Time::HiRes> module when you want to sleep.

  select undef, undef, undef, 0.25;         # not ok

  use Time::HiRes;
  sleep( 0.25 );                            # ok

=head1 SEE ALSO

L<Time::HiRes>.

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

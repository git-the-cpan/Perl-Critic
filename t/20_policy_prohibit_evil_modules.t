#!perl

##############################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/branches/Perl-Critic-1.109/t/20_policy_prohibit_evil_modules.t $
#     $Date: 2010-08-29 20:53:20 -0500 (Sun, 29 Aug 2010) $
#   $Author: clonezone $
# $Revision: 3911 $
##############################################################################

use 5.006001;
use strict;
use warnings;

use Perl::Critic::TestUtils qw< pcritique >;
use Perl::Critic::Utils     qw< $EMPTY >;

use Test::More tests => 1;

#-----------------------------------------------------------------------------

our $VERSION = '1.109';

#-----------------------------------------------------------------------------

Perl::Critic::TestUtils::block_perlcriticrc();

# This is in addition to the regular .run file.

my $policy = 'Modules::ProhibitEvilModules';

my $code = <<'END_PERL';

use Evil::Module qw(bad stuff);
use Super::Evil::Module;

END_PERL

my $result = eval { pcritique( $policy, \$code, {modules => $EMPTY} ); 1; };
ok(
    ! $result,
    "$policy does not run if there are no evil modules configured.",
);


#-----------------------------------------------------------------------------

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 78
#   indent-tabs-mode: nil
#   c-indentation-style: bsd
# End:
# ex: set ts=8 sts=4 sw=4 tw=78 ft=perl expandtab shiftround :

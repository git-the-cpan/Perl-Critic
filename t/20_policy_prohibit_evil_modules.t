#!perl

##############################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/tags/Perl-Critic-1.105_001/t/20_policy_prohibit_evil_modules.t $
#     $Date: 2010-01-16 11:22:15 -0800 (Sat, 16 Jan 2010) $
#   $Author: thaljef $
# $Revision: 3746 $
##############################################################################

use 5.006001;
use strict;
use warnings;

# common P::C testing tools
use Perl::Critic::TestUtils qw(pcritique);

use Test::More tests => 1;

#-----------------------------------------------------------------------------

our $VERSION = '1.105_01';

#-----------------------------------------------------------------------------

Perl::Critic::TestUtils::block_perlcriticrc();

# This is in addition to the regular .run file.

my $policy = 'Modules::ProhibitEvilModules';

my $code = <<'END_PERL';

use Evil::Module qw(bad stuff);
use Super::Evil::Module;

END_PERL

my $result = eval { pcritique($policy, \$code); 1; };
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

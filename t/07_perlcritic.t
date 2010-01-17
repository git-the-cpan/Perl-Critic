#!perl

##############################################################################
#     $URL: http://perlcritic.tigris.org/svn/perlcritic/tags/Perl-Critic-1.105_001/t/07_perlcritic.t $
#    $Date: 2010-01-16 11:22:15 -0800 (Sat, 16 Jan 2010) $
#   $Author: thaljef $
# $Revision: 3746 $
##############################################################################

use 5.006001;
use strict;
use warnings;

use File::Spec;

use Test::More tests => 1;

#-----------------------------------------------------------------------------

our $VERSION = '1.105_01';

#-----------------------------------------------------------------------------

my $perlcritic = File::Spec->catfile( qw(blib script perlcritic) );
if (not -e $perlcritic) {
    $perlcritic = File::Spec->catfile( qw(bin perlcritic) )
}

require_ok($perlcritic);

#-----------------------------------------------------------------------------

# ensure we return true if this test is loaded by
# t/07_perlcritic.t_without_optional_dependencies.t
1;

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 78
#   indent-tabs-mode: nil
#   c-indentation-style: bsd
# End:
# ex: set ts=8 sts=4 sw=4 tw=78 ft=perl expandtab shiftround :

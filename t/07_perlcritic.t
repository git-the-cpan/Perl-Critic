#!perl

##############################################################################
#     $URL: http://perlcritic.tigris.org/svn/perlcritic/branches/Perl-Critic-1.109/t/07_perlcritic.t $
#    $Date: 2010-08-29 20:53:20 -0500 (Sun, 29 Aug 2010) $
#   $Author: clonezone $
# $Revision: 3911 $
##############################################################################

use 5.006001;
use strict;
use warnings;

use File::Spec;

use Test::More tests => 1;

#-----------------------------------------------------------------------------

our $VERSION = '1.109';

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

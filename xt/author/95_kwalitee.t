#!/usr/bin/perl

##############################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/tags/Perl-Critic-1.091/xt/author/95_kwalitee.t $
#     $Date: 2008-09-01 21:36:59 -0700 (Mon, 01 Sep 2008) $
#   $Author: thaljef $
# $Revision: 2715 $
##############################################################################

use strict;
use warnings;

use English qw< -no_match_vars >;

use Test::More;

#-----------------------------------------------------------------------------

our $VERSION = '1.091';

#-----------------------------------------------------------------------------

eval {
   require Test::Kwalitee;
   Test::Kwalitee->import( tests => [ qw{ -no_symlinks } ] );
   1;
}
    or plan skip_all => 'Test::Kwalitee not installed; skipping';

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 78
#   indent-tabs-mode: nil
#   c-indentation-style: bsd
# End:
# ex: set ts=8 sts=4 sw=4 tw=78 ft=perl expandtab shiftround :

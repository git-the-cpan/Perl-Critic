#!/usr/bin/perl

##############################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/trunk/distributions/Perl-Critic/xt/author/95_kwalitee.t $
#     $Date: 2009-06-27 20:02:58 -0400 (Sat, 27 Jun 2009) $
#   $Author: clonezone $
# $Revision: 3373 $
##############################################################################

use strict;
use warnings;

use English qw< -no_match_vars >;

use Test::More;

#-----------------------------------------------------------------------------

our $VERSION = '1.099_002';

#-----------------------------------------------------------------------------

use Test::Kwalitee tests => [ qw{ -no_symlinks } ];

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 78
#   indent-tabs-mode: nil
#   c-indentation-style: bsd
# End:
# ex: set ts=8 sts=4 sw=4 tw=78 ft=perl expandtab shiftround :

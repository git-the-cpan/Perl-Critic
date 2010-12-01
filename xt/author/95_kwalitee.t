#!/usr/bin/perl

##############################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/trunk/distributions/Perl-Critic/xt/author/95_kwalitee.t $
#     $Date: 2010-11-30 21:05:15 -0600 (Tue, 30 Nov 2010) $
#   $Author: clonezone $
# $Revision: 3998 $
##############################################################################

use strict;
use warnings;

use English qw< -no_match_vars >;

use Test::More;

#-----------------------------------------------------------------------------

our $VERSION = '1.110_001';

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

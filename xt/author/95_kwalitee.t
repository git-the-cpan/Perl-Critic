#!/usr/bin/perl

##############################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/trunk/distributions/Perl-Critic/xt/author/95_kwalitee.t $
#     $Date: 2011-02-14 19:31:57 -0600 (Mon, 14 Feb 2011) $
#   $Author: clonezone $
# $Revision: 4040 $
##############################################################################

use strict;
use warnings;

use English qw< -no_match_vars >;

use Test::More;

#-----------------------------------------------------------------------------

our $VERSION = '1.113';

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

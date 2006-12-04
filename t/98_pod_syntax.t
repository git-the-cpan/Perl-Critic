#!perl

##############################################################################
#     $URL: http://perlcritic.tigris.org/svn/perlcritic/tags/Perl-Critic-0.21_01/t/98_pod_syntax.t $
#    $Date: 2006-12-03 23:40:05 -0800 (Sun, 03 Dec 2006) $
#   $Author: thaljef $
# $Revision: 1030 $
##############################################################################

use strict;
use warnings;
use Test::More;

eval 'use Test::Pod 1.00';  ## no critic
plan skip_all => 'Test::Pod 1.00 required for testing POD' if $@;
all_pod_files_ok();# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 78
#   indent-tabs-mode: nil
#   c-indentation-style: bsd
# End:
# ex: set ts=8 sts=4 sw=4 tw=78 ft=perl expandtab :

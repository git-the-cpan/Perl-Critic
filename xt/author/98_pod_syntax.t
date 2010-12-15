#!perl

##############################################################################
#     $URL: http://perlcritic.tigris.org/svn/perlcritic/branches/Perl-Critic-1.111/xt/author/98_pod_syntax.t $
#    $Date: 2010-12-14 20:07:55 -0600 (Tue, 14 Dec 2010) $
#   $Author: clonezone $
# $Revision: 4008 $
##############################################################################

use 5.006001;
use strict;
use warnings;

use Perl::Critic::TestUtils qw{ starting_points_including_examples };

use Test::More;

#-----------------------------------------------------------------------------

our $VERSION = '1.111';

#-----------------------------------------------------------------------------

use Test::Pod 1.00;

all_pod_files_ok( all_pod_files( starting_points_including_examples() ) );

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 78
#   indent-tabs-mode: nil
#   c-indentation-style: bsd
# End:
# ex: set ts=8 sts=4 sw=4 tw=78 ft=perl expandtab shiftround :

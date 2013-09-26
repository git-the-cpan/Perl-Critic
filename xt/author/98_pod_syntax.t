#!perl

##############################################################################
#     $URL: http://perlcritic.tigris.org/svn/perlcritic/trunk/distributions/Perl-Critic/xt/author/98_pod_syntax.t $
#    $Date: 2013-09-25 22:21:28 -0700 (Wed, 25 Sep 2013) $
#   $Author: thaljef $
# $Revision: 4171 $
##############################################################################

use 5.006001;
use strict;
use warnings;

use Perl::Critic::TestUtils qw{ starting_points_including_examples };

use Test::More;# 1.41;  # Need 1.41 or newer for correct support of L<text|scheme:...> links.

#-----------------------------------------------------------------------------

our $VERSION = '1.119';

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

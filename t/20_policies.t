#!perl

##############################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/branches/Perl-Critic-1.109/t/20_policies.t $
#     $Date: 2010-08-29 20:53:20 -0500 (Sun, 29 Aug 2010) $
#   $Author: clonezone $
# $Revision: 3911 $
##############################################################################

use 5.006001;

use strict;
use warnings;

use Test::Perl::Critic::Policy;

#-----------------------------------------------------------------------------

our $VERSION = '1.109';

#-----------------------------------------------------------------------------
# Notice that you can pass arguments to this test, which limit the testing to
# specific policies.  The arguments must be shortened policy names. When using
# prove(1), any arguments that follow '::' will be passed to the test script.

my %args = @ARGV ? ( -policies => [ @ARGV ] ) : ();
all_policies_ok(%args);

#-----------------------------------------------------------------------------
# ensure we return true if this test is loaded by
# 20_policies.t_without_optional_dependencies.t

1;

#-----------------------------------------------------------------------------
# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 78
#   indent-tabs-mode: nil
#   c-indentation-style: bsd
# End:
# ex: set ts=8 sts=4 sw=4 tw=78 ft=perl expandtab shiftround :

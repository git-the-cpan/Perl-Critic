#!perl

##############################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/branches/Perl-Critic-1.111/t/05_utils_perl.t $
#     $Date: 2010-12-14 20:07:55 -0600 (Tue, 14 Dec 2010) $
#   $Author: clonezone $
# $Revision: 4008 $
##############################################################################

use 5.006001;
use strict;
use warnings;

use Readonly;


use Perl::Critic::Utils::Perl qw< :all >;


use Test::More tests => 7;

#-----------------------------------------------------------------------------

our $VERSION = '1.111';

#-----------------------------------------------------------------------------
#  export tests

can_ok('main', 'symbol_without_sigil');

#-----------------------------------------------------------------------------
#  name_without_sigil tests

{
    foreach my $sigil ( q<>, qw< $ @ % * & > ) {
        my $symbol = "${sigil}foo";
        is(
            symbol_without_sigil($symbol),
            'foo',
            "symbol_without_sigil($symbol)",
        );
    }
}

#-----------------------------------------------------------------------------

# ensure we return true if this test is loaded by
# t/05_utils_ppi.t_without_optional_dependencies.t
1;

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 78
#   indent-tabs-mode: nil
#   c-indentation-style: bsd
# End:
# ex: set ts=8 sts=4 sw=4 tw=78 ft=perl expandtab shiftround :

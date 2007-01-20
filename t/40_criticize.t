#!perl

##############################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/trunk/Perl-Critic/t/40_criticize.t $
#     $Date: 2006-12-03 16:48:50 -0800 (Sun, 03 Dec 2006) $
#   $Author: clonezone $
# $Revision: 1014 $
##############################################################################

# Self-compliance tests

use strict;
use warnings;
use English qw( -no_match_vars );
use File::Spec qw();
use Test::More;
use Perl::Critic::PolicyFactory ( -test => 1 );
use Perl::Critic::TestUtils qw{ should_skip_author_tests get_author_test_skip_message };

if (should_skip_author_tests()) {
    plan skip_all => get_author_test_skip_message();
}

#-----------------------------------------------------------------------------

eval { require Test::Perl::Critic; };
plan skip_all => 'Test::Perl::Critic required to criticise code' if $EVAL_ERROR;

#-----------------------------------------------------------------------------
# Set up PPI caching for speed (used primarily during development)

if ( $ENV{PERL_CRITIC_CACHE} ) {
    require File::Spec;
    require PPI::Cache;
    my $cache_path
        = File::Spec->catdir( File::Spec->tmpdir,
                              'test-perl-critic-cache-'.$ENV{USER} );
    if ( ! -d $cache_path) {
        mkdir $cache_path, oct 700;
    }
    PPI::Cache->import( path => $cache_path );
}

#-----------------------------------------------------------------------------
# Strict object testing -- prevent direct hash key access

eval { require Devel::EnforceEncapsulation; };
if ( !$EVAL_ERROR ) {
    for my $pkg ( '', '::Config', '::Policy', '::Violation' ) {
        diag 'apply Devel::EnforceEncapsulation to Perl::Critic'.$pkg;
        Devel::EnforceEncapsulation->apply_to('Perl::Critic'.$pkg);
    }
}

#-----------------------------------------------------------------------------
# Run critic against all of our own files

my $rcfile = File::Spec->catfile( 't', '40_perlcriticrc' );
Test::Perl::Critic->import( -profile => $rcfile );
all_critic_ok();

#-----------------------------------------------------------------------------

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 78
#   indent-tabs-mode: nil
#   c-indentation-style: bsd
# End:
# ex: set ts=8 sts=4 sw=4 tw=78 ft=perl expandtab :

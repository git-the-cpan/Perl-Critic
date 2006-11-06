#!perl

##############################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/tags/Perl-Critic-0.21/t/40_criticize.t $
#     $Date: 2006-11-05 18:01:38 -0800 (Sun, 05 Nov 2006) $
#   $Author: thaljef $
# $Revision: 809 $
##############################################################################

# Self-compliance tests

use strict;
use warnings;
use English qw( -no_match_vars );
use File::Spec qw();
use Test::More;
use Perl::Critic::PolicyFactory ( -test => 1 );

if (!$ENV{TEST_AUTHOR}) {
    plan skip_all => 'Author test';
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
Test::Perl::Critic->import( -severity => 1, -profile => $rcfile );
all_critic_ok();

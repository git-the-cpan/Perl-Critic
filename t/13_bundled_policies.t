#!perl

##############################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/trunk/distributions/Perl-Critic/t/13_bundled_policies.t $
#     $Date: 2009-01-01 19:06:43 -0600 (Thu, 01 Jan 2009) $
#   $Author: clonezone $
# $Revision: 2949 $
##############################################################################

use 5.006001;
use strict;
use warnings;

use Perl::Critic::UserProfile;
use Perl::Critic::PolicyFactory (-test => 1);
use Perl::Critic::TestUtils qw(bundled_policy_names);

use Test::More tests => 1;

#-----------------------------------------------------------------------------

our $VERSION = '1.094001';

#-----------------------------------------------------------------------------

Perl::Critic::TestUtils::block_perlcriticrc();

#-----------------------------------------------------------------------------

my $profile = Perl::Critic::UserProfile->new();
my $factory = Perl::Critic::PolicyFactory->new( -profile => $profile );
my @found_policies = sort map { ref $_ } $factory->create_all_policies();
my $test_label = 'successfully loaded policies matches MANIFEST';
is_deeply( \@found_policies, [bundled_policy_names()], $test_label );

#-----------------------------------------------------------------------------

# ensure we run true if this test is loaded by
# t/13_bundled_policies.t_without_optional_dependencies.t
1;

##############################################################################
# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 78
#   indent-tabs-mode: nil
#   c-indentation-style: bsd
# End:
# ex: set ts=8 sts=4 sw=4 tw=78 ft=perl expandtab shiftround :

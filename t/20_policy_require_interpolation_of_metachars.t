#!perl

##############################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/branches/Perl-Critic-1.106/t/20_policy_require_interpolation_of_metachars.t $
#     $Date: 2010-05-10 22:15:46 -0500 (Mon, 10 May 2010) $
#   $Author: clonezone $
# $Revision: 3809 $
##############################################################################

use 5.006001;
use strict;
use warnings;

use Perl::Critic::TestUtils qw< pcritique >;

use Test::More;

#-----------------------------------------------------------------------------

our $VERSION = '1.106';

#-----------------------------------------------------------------------------

eval 'use Email::Address 1.889; 1'
    or plan skip_all => 'Email::Address 1.889 required for ValuesAndExpressions::RequireInterpolationOfMetachars to ignore email addresses.';

plan tests => 2;

#-----------------------------------------------------------------------------

Perl::Critic::TestUtils::block_perlcriticrc();

# This is in addition to the regular .run file.

my $policy = 'ValuesAndExpressions::RequireInterpolationOfMetachars';


my $code = <<'END_PERL';

$simple  = 'me@foo.bar';
$complex = q{don-quixote@man-from.lamancha.org};

END_PERL

my $result = pcritique($policy, \$code);
is(
    $result,
    0,
    "$policy exempts things that look like email addresses if Email::Address is installed.",
);


$code = <<'END_PERL';

$simple  = 'Email: me@foo.bar';
$complex = q{"don-quixote@man-from.lamancha.org" is my address};
send_email_to ('foo@bar.com', ...);

END_PERL

$result = pcritique($policy, \$code);
is(
    $result,
    0,
    "$policy exempts things email addresses in the middle of larger strings if Email::Address is installed.",
);


#-----------------------------------------------------------------------------

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 78
#   indent-tabs-mode: nil
#   c-indentation-style: bsd
# End:
# ex: set ts=8 sts=4 sw=4 tw=78 ft=perl expandtab shiftround :

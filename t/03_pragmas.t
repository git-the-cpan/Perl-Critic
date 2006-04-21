##################################################################
#     $URL: http://perlcritic.tigris.org/svn/perlcritic/trunk/Perl-Critic/t/03_pragmas.t $
#    $Date: 2006-04-20 07:21:14 -0700 (Thu, 20 Apr 2006) $
#   $Author: thaljef $
# $Revision: 385 $
##################################################################

use strict;
use warnings;
use Test::More tests => 25;
use Perl::Critic;

# common P::C testing tools
use lib qw(t/tlib);
use PerlCriticTestUtils qw(critique);
PerlCriticTestUtils::block_perlcriticrc();

# Configure Critic not to load certain policies.  This
# just make it a little easier to create test cases
my $profile = { '-CodeLayout::RequireTidyCode'     => {},
                '-Miscellanea::RequireRcsKeywords' => {},
};

my $code = undef;

#----------------------------------------------------------------

$code = <<'END_PERL';
package FOO;
use strict;
use warnings;
our $VERSION = 1.0;

require 'some_library.pl';  ## no critic
print $crap if $condition;  ## no critic

1;
END_PERL

is( critique(\$code, {-profile => $profile, -severity => 1} ), 0, 'inline no-critic');

#----------------------------------------------------------------

$code = <<'END_PERL';
package FOO;
use strict;
use warnings;
our $VERSION = 1.0;

$foo = $bar;

## no critic

require 'some_library.pl';
print $crap if $condition;

## use critic

$baz = $nuts;
1;
END_PERL

is( critique(\$code, {-profile => $profile, -severity => 1} ), 0, 'region no-critic');

#----------------------------------------------------------------

$code = <<'END_PERL';
package FOO;
use strict;
use warnings;
our $VERSION = 1.0;

for my $foo (@list) {
  ## no critic
  $long_int = 12345678;
  $oct_num  = 033;
}

my $noisy = '!';

1;
END_PERL

is( critique(\$code, {-profile => $profile, -severity => 1} ), 1, 'scoped no-critic');

#----------------------------------------------------------------

$code = <<'END_PERL';
package FOO;
use strict;
use warnings;
our $VERSION = 1.0;

{
  ## no critic
  $long_int = 12345678;
  $oct_num  = 033;
}

my $noisy = '!';

1;
END_PERL

is( critique(\$code, {-profile => $profile, -severity => 1} ), 1, 'scoped no-critic');

#----------------------------------------------------------------

$code = <<'END_PERL';
package FOO;
use strict;
use warnings;
our $VERSION = 1.0;

## no critic
for my $foo (@list) {
  $long_int = 12345678;
  $oct_num  = 033;
}

## use critic
my $noisy = '!';

1;
END_PERL

is( critique(\$code, {-profile => $profile, -severity => 1} ), 1, 'region no-critic across a scope');

#----------------------------------------------------------------

$code = <<'END_PERL';
package FOO;
use strict;
use warnings;
our $VERSION = 1.0;

for my $foo (@list) {
  ## no critic
  $long_int = 12345678;
  $oct_num  = 033;
  ## use critic
}

my $noisy = '!';
my $empty = '';

1;
END_PERL

is( critique(\$code, {-profile => $profile, -severity => 1} ), 2, 'scoped region no-critic');

#----------------------------------------------------------------

$code = <<'END_PERL';
package FOO;
use strict;
use warnings;
our $VERSION = 1.0;

## no critic
for my $foo (@list) {
  $long_int = 12345678;
  $oct_num  = 033;
}

my $noisy = '!';
my $empty = '';

#No final '1;'
END_PERL

is( critique(\$code, {-profile => $profile, -severity => 1} ), 0, 'unterminated no-critic across a scope');

#----------------------------------------------------------------

$code = <<'END_PERL';
package FOO;
use strict;
use warnings;
our $VERSION = 1.0;

$long_int = 12345678;  ## no critic
$oct_num  = 033;       ## no critic
my $noisy = '!';       ## no critic
my $empty = '';        ## no critic
my $empty = '';        ## use critic

1;
END_PERL

is( critique(\$code, {-profile => $profile, -severity => 1} ), 1, 'inline use-critic');

#----------------------------------------------------------------

$code = <<'END_PERL';
package FOO;
use strict;
use warnings;
our $VERSION = 1.0;

$long_int = 12345678;  ## no critic
$oct_num  = 033;       ## no critic
my $noisy = '!';       ## no critic
my $empty = '';        ## no critic

$long_int = 12345678;
$oct_num  = 033;
my $noisy = '!';
my $empty = '';

#No final '1;'
END_PERL

is( critique(\$code, {-profile => $profile, -severity => 1} ), 5, 'inline no-critic');

#----------------------------------------------------------------

$code = <<'END_PERL';
package FOO;
use strict;
use warnings;
our $VERSION = 1.0;

$long_int = 12345678;  ## no critic
$oct_num  = 033;       ## no critic
my $noisy = '!';       ## no critic
my $empty = '';        ## no critic

## no critic
$long_int = 12345678;
$oct_num  = 033;
my $noisy = '!';
my $empty = '';

#No final '1;'
END_PERL

is( critique(\$code, {-profile  => $profile,
                      -severity => 1,
                      -force    => 1 } ), 9, 'force option');

#----------------------------------------------------------------

$code = <<'END_PERL';
package FOO;
use strict;
use warnings;
our $VERSION = 1.0;

for my $foo (@list) {
  ## no critic
  $long_int = 12345678;
  $oct_num  = 033;
}

my $noisy = '!'; ## no critic
my $empty = '';  ## no critic

1;
END_PERL

is( critique(\$code, {-profile  => $profile,
                      -severity => 1,
                      -force    => 1 } ), 4, 'force option');

#----------------------------------------------------------------

$code = <<'END_PERL';
package FOO;
use strict;
use warnings;
our $VERSION = 1.0;

for my $foo (@list) {
  ## no critic
  $long_int = 12345678;
  $oct_num  = 033;
}

## no critic
my $noisy = '!';
my $empty = '';

#No final '1;'
END_PERL

is( critique(\$code, {-profile  => $profile,
                      -severity => 1,
                      -force    => 1 } ), 5, 'force option');

#----------------------------------------------------------------
# Check that '## no critic' on the top of a block doesn't extend
# to all code within the block.  See RT bug #15295

$code = <<'END_PERL';
package FOO;
use strict;
use warnings;
our $VERSION = 1.0;

for ($i;$i++;$i<$j) { ## no critic
    my $long_int = 12345678;
    my $oct_num  = 033;
}

unless ( $condition1
         && $condition2 ) { ## no critic
    my $noisy = '!';
    my $empty = '';
}

1;
END_PERL

is( critique(\$code, {-profile  => $profile, -severity => 1} ), 4, 'RT bug 15295');

#----------------------------------------------------------------
# Check that '## no critic' on the top of a block doesn't extend
# to all code within the block.  See RT bug #15295

$code = <<'END_PERL';
package FOO;
use strict;
use warnings;
our $VERSION = 1.0;

for ($i; $i++; $i<$j) { ## no critic
    my $long_int = 12345678;
    my $oct_num  = 033;
}

#Between blocks now
$Global::Variable = "foo";  #Package var; double-quotes

unless ( $condition1
         && $condition2 ) { ## no critic
    my $noisy = '!';
    my $empty = '';
}

1;
END_PERL

is( critique(\$code, {-profile  => $profile, -severity => 1 } ), 6, 'RT bug 15295');

#----------------------------------------------------------------

$code = <<'END_PERL';
package FOO;
use strict;
use warnings;
our $VERSION = 1.0;

## no critic 'NoisyQuotes'
my $noisy = '!';
my $empty = '';
eval $string;

1;
END_PERL

is( critique(\$code, {-profile  => $profile, -severity => 1 } ), 2, 'per-policy no-critic');

#----------------------------------------------------------------

$code = <<'END_PERL';
package FOO;
use strict;
use warnings;
our $VERSION = 1.0;

## no critic qw(ValuesAndExpressions)
my $noisy = '!';
my $empty = '';
eval $string;

1;
END_PERL

is( critique(\$code, {-profile  => $profile, -severity => 1 } ), 1, 'per-policy no-critic');

#----------------------------------------------------------------

$code = <<'END_PERL';
package FOO;
use strict;
use warnings;
our $VERSION = 1.0;

## no critic ('Noisy', 'Empty')
my $noisy = '!';
my $empty = '';
eval $string;

1;
END_PERL

is( critique(\$code, {-profile  => $profile, -severity => 1 } ), 1, 'per-policy no-critic');

#----------------------------------------------------------------

$code = <<'END_PERL';
package FOO;
use strict;
use warnings;
our $VERSION = 1.0;

## no critic qw(NOISY EMPTY EVAL)
my $noisy = '!';
my $empty = '';
eval $string;

1;
END_PERL

is( critique(\$code, {-profile  => $profile, -severity => 1 } ), 0, 'per-policy no-critic');

#----------------------------------------------------------------

$code = <<'END_PERL';
package FOO;
use strict;
use warnings;
our $VERSION = 1.0;

## no critic qw(Noisy Empty Eval)
my $noisy = '!';
my $empty = '';
eval $string;

## use critic
my $noisy = '!';
my $empty = '';
eval $string;

1;
END_PERL

is( critique(\$code, {-profile  => $profile, -severity => 1 } ), 3, 'per-policy no-critic');

#----------------------------------------------------------------

$code = <<'END_PERL';
package FOO;
use strict;
use warnings;
our $VERSION = 1.0;

## no critic "Critic::Policy"
my $noisy = '!';
my $empty = '';
eval $string;

1;
END_PERL

is( critique(\$code, {-profile  => $profile, -severity => 1 } ), 0, 'per-policy no-critic');

#----------------------------------------------------------------

$code = <<'END_PERL';
package FOO;
use strict;
use warnings;
our $VERSION = 1.0;

## no critic qw(Foo::Bar Baz Boom)
my $noisy = '!';
my $empty = '';
eval $string;

1;
END_PERL

is( critique(\$code, {-profile  => $profile, -severity => 1 } ), 3, 'per-policy no-critic');

#----------------------------------------------------------------

$code = <<'END_PERL';
package FOO;
use strict;
use warnings;
our $VERSION = 1.0;

## no critic qw(Noisy);
my $noisy = '!';     #Should not find this
my $empty = '';      #Should find this

sub foo {

   ## no critic qw(Empty);
   my $nosiy = '!';  #Should not find this
   my $empty = '';   #Should not find this
   ## use critic;

   return 1;
}

my $nosiy = '!';  #Should not find this
my $empty = '';   #Should find this

1;
END_PERL

is( critique(\$code, {-profile  => $profile, -severity => 1 } ), 2, 'per-policy no-critic');

#----------------------------------------------------------------
# Most policies apply to a particular type of PPI::Element and usually
# only return one Violation at a time.  But the next three cases
# involve policies that apply to the whole document and can return
# multiple violations at a time.  These tests make sure that the 'no
# critic' pragmas are effective with those Policies
#----------------------------------------------------------------

$code = <<'END_PERL';
package FOO;

#Code before 'use strict'
my $foo = 'baz';  ## no critic
my $bar = 42;  # Should find this

use strict;
use warnings;
our $VERSION = 1.0;

1;
END_PERL

is( critique(\$code, {-profile  => $profile} ), 1, 'no critic & RequireUseStrict');

#----------------------------------------------------------------

$code = <<'END_PERL';
package FOO;

#Code before 'use warnings'
my $foo = 'baz';  ## no critic
my $bar = 42;  # Should find this

use strict;
use warnings;
our $VERSION = 1.0;

1;
END_PERL

is( critique(\$code, {-profile  => $profile} ), 1, 'no critic & RequireUseWarnings');

#----------------------------------------------------------------

$code = <<'END_PERL';
#Code before 'package' declaration
my $foo = 'baz';  ## no critic
my $bar = 42;  # Should find this

package FOO;

use strict;
use warnings;
our $VERSION = 1.0;

1;
END_PERL

is( critique(\$code, {-profile  => $profile} ), 1, 'no critic & RequireExplicitPackage');

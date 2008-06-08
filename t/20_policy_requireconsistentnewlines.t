#!perl

##############################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/trunk/Perl-Critic/t/20_policy_requireconsistentnewlines.t $
#     $Date: 2008-06-06 00:48:04 -0500 (Fri, 06 Jun 2008) $
#   $Author: clonezone $
# $Revision: 2416 $
##############################################################################

use 5.006001;
use strict;
use warnings;
use Test::More tests => 29;

# common P::C testing tools
use Perl::Critic::TestUtils qw(pcritique fcritique);
Perl::Critic::TestUtils::block_perlcriticrc();

my $code;
my $policy = 'CodeLayout::RequireConsistentNewlines';

my $base_code = <<'END_PERL';
package My::Pkg;
my $str = <<"HEREDOC";
heredoc_body
heredoc_body
HEREDOC

=head1 POD_HEADER

pod pod pod

=cut

# comment_line

1; # inline_comment

__END__
end_body
__DATA__
DataLine1
DataLine2
END_PERL

is( fcritique($policy, \$base_code), 0, $policy );

my @lines = split m/\n/mx, $base_code;
for my $keyword (qw( Pkg; heredoc_body HEREDOC POD_HEADER pod =cut
                     comment_line inline_comment
                     __END__ end_body __DATA__ DataLine1 DataLine2 )) {
    my $is_first_line = $lines[0] =~ m/\Q$keyword\E\z/mx;
    my $nfail = $is_first_line ? @lines-1 : 1;
    for my $nl ("\012", "\015", "\015\012") {
        next if $nl eq "\n";
        ($code = $base_code) =~ s/(\Q$keyword\E)\n/$1$nl/;
        is( fcritique($policy, \$code), $nfail, $policy.' - '.$keyword );
    }
}

for my $nl ("\012", "\015", "\015\012") {
    next if $nl eq "\n";
    ($code = $base_code) =~ s/\n/$nl/;
    is( pcritique($policy, \$code), 0, $policy.' - no filename' );
}

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 78
#   indent-tabs-mode: nil
#   c-indentation-style: bsd
# End:
# ex: set ts=8 sts=4 sw=4 tw=78 ft=perl expandtab shiftround :

##############################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/branches/Perl-Critic-backlog/lib/Perl/Critic/Policy/CodeLayout/RequireTidyCode.pm $
#     $Date: 2009-08-23 16:18:28 -0500 (Sun, 23 Aug 2009) $
#   $Author: clonezone $
# $Revision: 3609 $
##############################################################################

package Perl::Critic::Policy::CodeLayout::RequireTidyCode;

use 5.006001;
use strict;
use warnings;
use Readonly;

use English qw(-no_match_vars);
use Perl::Critic::Utils qw{ :booleans :characters :severities };
use base 'Perl::Critic::Policy';

our $VERSION = '1.104';

#-----------------------------------------------------------------------------

Readonly::Scalar my $DESC => q{Code is not tidy};
Readonly::Scalar my $EXPL => [ 33 ];

#-----------------------------------------------------------------------------

sub supported_parameters {
    return (
        {
            name            => 'perltidyrc',
            description     => 'The Perl::Tidy configuration file to use, if any.',
            default_string  => undef,
        },
    );
}

sub default_severity { return $SEVERITY_LOWEST      }
sub default_themes   { return qw(core pbp cosmetic) }
sub applies_to       { return 'PPI::Document'       }

#-----------------------------------------------------------------------------

sub initialize_if_enabled {
    my ($self, $config) = @_;

    # workaround for Test::Without::Module v0.11
    local $EVAL_ERROR = undef;

    # If Perl::Tidy is missing, bow out.
    eval { require Perl::Tidy; } or return $FALSE;

    #Set configuration if defined
    if (defined $self->{_perltidyrc} && $self->{_perltidyrc} eq $EMPTY) {
        $self->{_perltidyrc} = \$EMPTY;
    }

    return $TRUE;
}

#-----------------------------------------------------------------------------

sub violates {
    my ( $self, $elem, $doc ) = @_;

    # Perl::Tidy seems to produce slightly different output, depending
    # on the trailing whitespace in the input.  As best I can tell,
    # Perl::Tidy will truncate any extra trailing newlines, and if the
    # input has no trailing newline, then it adds one.  But when you
    # re-run it through Perl::Tidy here, that final newline gets lost,
    # which causes the policy to insist that the code is not tidy.
    # This only occurs when Perl::Tidy is writing the output to a
    # scalar, but does not occur when writing to a file.  I may
    # investigate further, but for now, this seems to do the trick.

    my $source = $doc->serialize();
    $source =~ s{ \s+ \Z}{\n}xms;

    # Remove the shell fix code from the top of program, if applicable
    ## no critic (ProhibitComplexRegexes)
    my $shebang_re = qr< [#]! [^\015\012]+ [\015\012]+ >xms;
    my $shell_re   = qr<eval [ ] 'exec [ ] [^\015\012]* [ ] \$0 [ ] \${1[+]"\$@"}'
                        [ \t]*[\012\015]+ [ \t]* if [^\015\012]+ [\015\012]+ >xms;
    $source =~ s/\A ($shebang_re) $shell_re /$1/xms;

    my $dest    = $EMPTY;
    my $stderr  = $EMPTY;


    # Perl::Tidy gets confused if @ARGV has arguments from
    # another program.  Also, we need to override the
    # stdout and stderr redirects that the user may have
    # configured in their .perltidyrc file.
    local @ARGV = qw(-nst -nse);

    # Trap Perl::Tidy errors, just in case it dies
    my $eval_worked = eval {
        Perl::Tidy::perltidy(
            source      => \$source,
            destination => \$dest,
            stderr      => \$stderr,
            defined $self->{_perltidyrc} ? (perltidyrc => $self->{_perltidyrc}) : (),
       );
       1;
    };

    if ($stderr or not $eval_worked) {
        # Looks like perltidy had problems
        return $self->violation( 'perltidy had errors!!', $EXPL, $elem );
    }

    if ( $source ne $dest ) {
        return $self->violation( $DESC, $EXPL, $elem );
    }

    return;    #ok!
}

1;

#-----------------------------------------------------------------------------

__END__

=pod

=for stopwords perltidy

=head1 NAME

Perl::Critic::Policy::CodeLayout::RequireTidyCode - Must run code through L<perltidy|perltidy>.


=head1 AFFILIATION

This Policy is part of the core L<Perl::Critic|Perl::Critic>
distribution.


=head1 DESCRIPTION

Conway does make specific recommendations for whitespace and
curly-braces in your code, but the most important thing is to adopt a
consistent layout, regardless of the specifics.  And the easiest way
to do that is to use L<Perl::Tidy|Perl::Tidy>.  This policy will
complain if you're code hasn't been run through Perl::Tidy.


=head1 CONFIGURATION

This policy can be configured to tell Perl::Tidy to use a particular
F<perltidyrc> file or no configuration at all.  By default, Perl::Tidy
is told to look in its default location for configuration.
Perl::Critic can be told to tell Perl::Tidy to use a specific
configuration file by putting an entry in a F<.perlcriticrc> file like
this:

    [CodeLayout::RequireTidyCode]
    perltidyrc = /usr/share/perltidy.conf

As a special case, setting C<perltidyrc> to the empty string tells
Perl::Tidy not to load any configuration file at all and just use
Perl::Tidy's own default style.

    [CodeLayout::RequireTidyCode]
    perltidyrc =


=head1 PREREQUISITES

L<Perl::Tidy|Perl::Tidy> is not included in the Perl::Critic
distribution.  The latest version of Perl::Tidy can be downloaded from
CPAN.  If Perl::Tidy is not installed, this policy will disable
itself.


=head1 SEE ALSO

L<Perl::Tidy|Perl::Tidy>


=head1 AUTHOR

Jeffrey Ryan Thalhammer <thaljef@cpan.org>


=head1 COPYRIGHT

Copyright (c) 2005-2009 Jeffrey Ryan Thalhammer.  All rights reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.  The full text of this license
can be found in the LICENSE file included with this module.

=cut

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 78
#   indent-tabs-mode: nil
#   c-indentation-style: bsd
# End:
# ex: set ts=8 sts=4 sw=4 tw=78 ft=perl expandtab shiftround :

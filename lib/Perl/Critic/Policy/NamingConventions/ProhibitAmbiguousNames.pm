#######################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/trunk/Perl-Critic/lib/Perl/Critic/Policy/NamingConventions/ProhibitAmbiguousNames.pm $
#     $Date: 2006-05-22 21:42:53 -0700 (Mon, 22 May 2006) $
#   $Author: thaljef $
# $Revision: 431 $
########################################################################

package Perl::Critic::Policy::NamingConventions::ProhibitAmbiguousNames;

use strict;
use warnings;
use Perl::Critic::Violation;
use Perl::Critic::Utils;
use base 'Perl::Critic::Policy';

our $VERSION = '0.17';
$VERSION = eval $VERSION;    ## no critic

#---------------------------------------------------------------------------

my $desc = 'Ambiguous name for variable or subroutine';
my $expl = [ 48 ];

my @default_forbid =
    qw( last      contract
        set       record
        left      second
        right     close
        no        bases
        abstract
);

#---------------------------------------------------------------------------

sub default_severity { return $SEVERITY_MEDIUM }
sub applies_to { return 'PPI::Statement::Sub', 'PPI::Statement::Variable' }

#---------------------------------------------------------------------------

sub new {
    my ( $class, %args ) = @_;
    my $self = bless {}, $class;

    #Set configuration, if defined
    if ( defined $args{forbid} ) {
        my @forbid = split m{ \s+ }mx, $args{forbid};
        $self->{_forbid} = { map { $_ => 1 } @forbid };
    }
    else {
        $self->{_forbid} = { map { $_ => 1 } @default_forbid };
    }

    return $self;
}

#---------------------------------------------------------------------------

sub default_forbidden_words { return @default_forbid }

#---------------------------------------------------------------------------

sub violates {
    my ( $self, $elem, $doc ) = @_;

    if ( $elem->isa('PPI::Statement::Sub') ) {
        my @words = grep { $_->isa('PPI::Token::Word') } $elem->schildren();
        for my $word (@words) {

            # strip off any leading "Package::"
            my ($name) = $word =~ m/ (\w+) \z /xms;
            if ( defined $name && $self->{_forbid}->{$name} ) {
                my $sev = $self->get_severity();
                return Perl::Critic::Violation->new($desc, $expl, $elem, $sev);
            }
        }
        return;    # ok
    }
    else {         # PPI::Statement::Variable

        # Accumulate them since there can be more than one violation
        # per variable statement
        my @viols;

        # TODO: false positive bug - this can erroneously catch the
        # assignment half of a variable statement

        my $symbols = $elem->find('PPI::Token::Symbol');
        if ($symbols) {
            for my $symbol ( @{$symbols} ) {

                # Strip off sigil and any leading "Package::"
                # Beware that punctuation vars may have no
                # alphanumeric characters.

                my ($name) = $symbol =~ m/ (\w+) \z /xms;
                next if ! defined $name;

                if ( defined $self->{_forbid}->{$name} ) {
                    my $sev = $self->get_severity;
                    push @viols, Perl::Critic::Violation->new($desc, $expl, $elem, $sev);
                }
            }
        }
        return @viols;
    }
}

1;

__END__

#---------------------------------------------------------------------------

=pod

=for stopwords bioinformatics

=head1 NAME

Perl::Critic::Policy::NamingConventions::ProhibitAmbiguousNames

=head1 DESCRIPTION

Conway lists a collection of English words which are highly ambiguous
as variable or subroutine names.  For example, C<$last> can mean
previous or final.

This policy tests against a list of ambiguous words for variable
names.

=head1 CONSTRUCTOR

This Policy accepts an additional key-value pair in the constructor,
The key is 'forbid' and the value is a string of forbidden words
separated by spaces.  Any specified list replaces the default list.

The default list is:

    last set left right no abstract contract record second close bases

For example, to override the default list:

    my $pkg = 'Perl::Critic::Policy::NamingConventions::ProhibitAmbiguousNames';
    my $policy = $pkg->new(forbid => 'last set');

=head1 METHODS

=over 8

=item default_forbidden_words()

This can be called as a class or instance method.  It returns the list
of words that are forbidden by default.  This list can be overridden
via a perlcriticrc file.

For example, if you decide that C<bases> is an OK name for variables
(e.g. in bioinformatics), then put something like the following in
C<$HOME/.perlcriticrc>:

    [NamingConventions::ProhibitAmbiguousNames]
    forbid = last set left right no abstract contract record second close

=back

=head1 BUGS

Currently this policy checks the entire variable and subroutine name,
not parts of the name.  For example, it catches C<$last> but not
C<$last_record>.  Hopefully future versions will catch both cases.

Some variable statements will be false positives if they have
assignments where the right hand side uses forbidden names.  For
example, in this case the C<last> incorrectly triggers a violation.

    my $previous_record = $Foo::last;

=head1 AUTHOR

Chris Dolan <cdolan@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2005-2006 Chris Dolan.  All rights reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.  The full text of this license
can be found in the LICENSE file included with this module.

=cut

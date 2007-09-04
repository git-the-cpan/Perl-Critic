##############################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/branches/Perl-Critic-1.073/inc/Perl/Critic/BuildUtilities.pm $
#     $Date: 2007-09-04 01:00:24 -0500 (Tue, 04 Sep 2007) $
#   $Author: clonezone $
# $Revision: 1874 $
##############################################################################

package Perl::Critic::BuildUtilities;

use strict;
use warnings;

our $VERSION = 1.073;

use base qw{ Exporter };

our @EXPORT_OK = qw{
    &recommended_module_versions
    &test_wrappers_to_generate
};

sub recommended_module_versions {
    return (
        'File::HomeDir'         => 0,
        'Perl::Tidy'            => 0,

        # All of these are for Documentation::PodSpelling
        'File::Which'           => 0,
        'IPC::Open2'            => 1,
        'Pod::Spell'            => 1,
        'Text::ParseWords'      => 3,
    );
}

sub test_wrappers_to_generate {
    my @tests_to_be_wrapped = qw{
        t/00_modules.t
        t/01_config.t
        t/01_config_bad_perlcriticrc.t
        t/02_policy.t
        t/03_pragmas.t
        t/04_defaults.t
        t/05_utils.t
        t/05_utils_ppi.t
        t/06_violation.t
        t/07_perlcritic.t
        t/08_document.t
        t/09_theme.t
        t/10_userprofile.t
        t/11_policyfactory.t
        t/12_policylisting.t
        t/13_bundled_policies.t
        t/14_policy_parameters.t
        t/15_statistics.t
        t/20_policy_podspelling.t
        t/20_policy_requiretidycode.t
        t/80_policysummary.t
        t/92_memory_leaks.t
        t/94_includes.t
    };

    return
        map
            { $_ . '_without_optional_dependencies.t' }
            @tests_to_be_wrapped;
}


1;

__END__

=head1 NAME

Perl::Critic::BuildUtilities - Common bits of compiling Perl::Critic.


=head1 DESCRIPTION

Various utilities used in assembling Perl::Critic, primary for use by
*.PL programs that generate code.


=head1 IMPORTABLE SUBROUTINES

=over

=item C<recommended_module_versions()>

Returns a hash mapping between recommended (but not required) modules
for Perl::Critic and the minimum version required of each module,


=item C<test_wrappers_to_generate()>

Returns a list of test wrappers to be generated by
F<t/generate_without_optional_dependencies_wrappers.PL>.


=back


=head1 AUTHOR

Elliot Shank  C<< <perl@galumph.com> >>


=head1 LICENCE AND COPYRIGHT

Copyright (c) 2007, Elliot Shank C<< <perl@galumph.com> >>. All rights
reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.  The full text of this license
can be found in the LICENSE file included with this module.

=cut

##############################################################################
# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 78
#   indent-tabs-mode: nil
#   c-indentation-style: bsd
# End:
# ex: set ts=8 sts=4 sw=4 tw=78 ft=perl expandtab :

##############################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/branches/Perl-Critic-1.106/lib/Perl/Critic/Exception/Configuration/Option/Global.pm $
#     $Date: 2010-05-10 22:15:46 -0500 (Mon, 10 May 2010) $
#   $Author: clonezone $
# $Revision: 3809 $
##############################################################################

package Perl::Critic::Exception::Configuration::Option::Global;

use 5.006001;
use strict;
use warnings;

our $VERSION = '1.106';

#-----------------------------------------------------------------------------

use Exception::Class (
    'Perl::Critic::Exception::Configuration::Option::Global' => {
        isa         => 'Perl::Critic::Exception::Configuration::Option',
        description => 'A problem with global Perl::Critic configuration.',
    },
);

#-----------------------------------------------------------------------------

1;

__END__

#-----------------------------------------------------------------------------

=pod

=for stopwords

=head1 NAME

Perl::Critic::Exception::Configuration::Option::Global - A problem with L<Perl::Critic|Perl::Critic> global configuration.

=head1 DESCRIPTION

A representation of a problem found with the global configuration of
L<Perl::Critic|Perl::Critic>, whether from a F<.perlcriticrc>, another
profile file, or command line.

This is an abstract class.  It should never be instantiated.


=head1 INTERFACE SUPPORT

This is considered to be a public class.  Any changes to its interface
will go through a deprecation cycle.


=head1 AUTHOR

Elliot Shank <perl@galumph.com>

=head1 COPYRIGHT

Copyright (c) 2007-2009 Elliot Shank.  All rights reserved.

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

##############################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/trunk/distributions/Perl-Critic/lib/Perl/Critic/Exception/Fatal/Internal.pm $
#     $Date: 2010-06-22 16:14:07 -0400 (Tue, 22 Jun 2010) $
#   $Author: clonezone $
# $Revision: 3843 $
##############################################################################

package Perl::Critic::Exception::Fatal::Internal;

use 5.006001;
use strict;
use warnings;

use Readonly;

our $VERSION = '1.108';

#-----------------------------------------------------------------------------

use Exception::Class (
    'Perl::Critic::Exception::Fatal::Internal' => {
        isa         => 'Perl::Critic::Exception::Fatal',
        description => 'A problem with the Perl::Critic code was found, a.k.a. a bug.',
        alias       => 'throw_internal',
    },
);

#-----------------------------------------------------------------------------

Readonly::Array our @EXPORT_OK => qw< throw_internal >;

#-----------------------------------------------------------------------------


1;

__END__

#-----------------------------------------------------------------------------

=pod

=for stopwords

=head1 NAME

Perl::Critic::Exception::Fatal::Internal - A problem with the L<Perl::Critic|Perl::Critic> implementation, i.e. a bug.

=head1 DESCRIPTION

A representation of a bug found in the code of
L<Perl::Critic|Perl::Critic>.


=head1 INTERFACE SUPPORT

This is considered to be a public class.  Any changes to its interface
will go through a deprecation cycle.


=head1 METHODS

Only inherited ones.


=head1 AUTHOR

Elliot Shank <perl@galumph.com>

=head1 COPYRIGHT

Copyright (c) 2007-2010 Elliot Shank.

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

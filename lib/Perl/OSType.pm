use strict;
use warnings;

package Perl::OSType;
# ABSTRACT: Map Perl operating system names to generic types

our $VERSION = '1.010';

require Exporter;
our @ISA = qw(Exporter);

our %EXPORT_TAGS = ( all => [qw( os_type is_os_type )] );

our @EXPORT_OK = @{ $EXPORT_TAGS{all} };

# originally taken from Module::Build by Ken Williams et al.
my %OSTYPES = qw(
  aix         Unix
  bsdos       Unix
  beos        Unix
  bitrig      Unix
  dgux        Unix
  dragonfly   Unix
  dynixptx    Unix
  freebsd     Unix
  linux       Unix
  haiku       Unix
  hpux        Unix
  iphoneos    Unix
  irix        Unix
  darwin      Unix
  machten     Unix
  midnightbsd Unix
  minix       Unix
  mirbsd      Unix
  next        Unix
  openbsd     Unix
  netbsd      Unix
  dec_osf     Unix
  nto         Unix
  svr4        Unix
  svr5        Unix
  sco         Unix
  sco_sv      Unix
  unicos      Unix
  unicosmk    Unix
  solaris     Unix
  sunos       Unix
  cygwin      Unix
  os2         Unix
  interix     Unix
  gnu         Unix
  gnukfreebsd Unix
  nto         Unix
  qnx         Unix
  android     Unix

  dos         Windows
  MSWin32     Windows

  os390       EBCDIC
  os400       EBCDIC
  posix-bc    EBCDIC
  vmesa       EBCDIC

  MacOS       MacOS
  VMS         VMS
  vos         VOS
  riscos      RiscOS
  amigaos     Amiga
  mpeix       MPEiX
);

sub os_type {
    my ($os) = @_;
    $os = $^O unless defined $os;
    return $OSTYPES{$os} || q{};
}

sub is_os_type {
    my ( $type, $os ) = @_;
    return unless $type;
    $os = $^O unless defined $os;
    return os_type($os) eq $type;
}

1;
__END__

=head1 SYNOPSIS

  use Perl::OSType ':all';

  $current_type = os_type();
  $other_type = os_type('dragonfly'); # gives 'Unix'

=head1 DESCRIPTION

Modules that provide OS-specific behaviors often need to know if
the current operating system matches a more generic type of
operating systems. For example, 'linux' is a type of 'Unix' operating system
and so is 'freebsd'.

This module provides a mapping between an operating system name as given by
C<$^O> and a more generic type.  The initial version is based on the OS type
mappings provided in L<Module::Build> and L<ExtUtils::CBuilder>.  (Thus,
Microsoft operating systems are given the type 'Windows' rather than 'Win32'.)

=head1 USAGE

No functions are exported by default. The export tag ":all" will export
all functions listed below.

=head2 os_type()

  $os_type = os_type();
  $os_type = os_type('MSWin32');

Returns a single, generic OS type for a given operating system name.  With no
arguments, returns the OS type for the current value of C<$^O>.  If the
operating system is not recognized, the function will return the empty string.

=head2 is_os_type()

  $is_windows = is_os_type('Windows');
  $is_unix    = is_os_type('Unix', 'dragonfly');

Given an OS type and OS name, returns true or false if the OS name is of the
given type.  As with C<os_type>, it will use the current operating system as a
default if no OS name is provided.

=head1 SEE ALSO

=over 4

=item *

L<Devel::CheckOS>

=back

=cut

# vim: ts=4 sts=4 sw=4 et:

package OSType;
use strict;
use warnings;

our $VERSION = '0.002';

require Exporter;
our @ISA = qw(Exporter);

our %EXPORT_TAGS = (
  all => [ qw( os_type is_os_type os_family is_os_family ) ]
);

our @EXPORT_OK = @{ $EXPORT_TAGS{all} };

# taken from Module::Build by Ken Williams et al.
my %OSTYPES = qw(
  aix         Unix
  bsdos       Unix
  dgux        Unix
  dragonfly   Unix
  dynixptx    Unix
  freebsd     Unix
  linux       Unix
  haiku       Unix
  hpux        Unix
  irix        Unix
  darwin      Unix
  machten     Unix
  midnightbsd Unix
  mirbsd      Unix
  next        Unix
  openbsd     Unix
  netbsd      Unix
  dec_osf     Unix
  nto         Unix
  svr4        Unix
  svr5        Unix
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

  dos         Windows
  MSWin32     Windows

  os390       EBCDIC
  os400       EBCDIC
  posix-bc    EBCDIC
  vmesa       EBCDIC

  MacOS       MacOS
  VMS         VMS
  VOS         VOS
  riscos      RiscOS
  amigaos     Amiga
  mpeix       MPEiX
);

# Adapted from Devel::CheckOS by David Cantrell
my %OSFAMILIES = (
  Unix => [ grep { $OSTYPES{$_} eq 'Unix' } keys %OSTYPES ],
  Apple => [ qw/darwin MacOS/ ],
  DEC => [ qw/dec_osf VMS/ ],
  MicrosoftWindows => [ qw/MSWin32 cygwin/ ],
  Realtime => [ qw/qnx/ ],
  Sun => [ qw/solaris sunos/ ],
);

sub os_type {
  my ($os) = @_;
  $os = $^O unless defined $os;
  return $OSTYPES{ $os } || q{};
}

sub is_os_type {
  my ($type, $os) = @_;
  return unless $type;
  $os = $^O unless defined $os;
  return os_type($os) eq $type;
}

sub os_family {
  my ($family) = @_;
  return unless defined $family && exists $OSFAMILIES{$family};
  my @names = @{ $OSFAMILIES{$family} };
  return wantarray ? @names : $names[0];
}

sub is_os_family {
  my ($family, $os) = @_;
  my @family = os_family($family);
  return unless @family;
  $os = $^O unless defined $os;
  return scalar grep { $_ eq $os } @family;
}

1;
__END__

=head1 NAME

OSType - Map operating system names to generic types or families

=head1 SYNOPSIS

  use OSType ':all';

  $current_type = os_type();
  $other_type = os_type('dragonfly'); # gives 'Unix'

  $is_sun = is_os_family("Sun");

=head1 DESCRIPTION

Modules that provide OS-specific behaviors often need to know if
the current operating system matches a more generic type or family of
operating systems. For example, 'linux' is a type of 'Unix' operating system
and so is 'freebsd'.

This module provides a mapping between an operating system name as given by
C<$^O> and a more generic type.  The initial version is based on the OS type
mappings provided in L<Module::Build> and L<ExtUtils::CBuilder>.  (Thus,
Microsoft operating systems are given the type 'Windows' rather than 'Win32'.)

=head2 OS Families

L<Devel::CheckOS> introduced the notion of OS families, which do not
necessarily correspond to types.  An operating system can belong to multiple
families.  Supported families include the following (descriptions are taken
nearly verbatim from Devel::CheckOS):

=over 4

=item *

Unix

Broadly speaking, these are platforms where:

=over

=item *

Devices are represented as pseudo-files in the filesystem

=item *

Symlinks and hardlinks are supported in at least some filesystems

=item *

"Unix-style" permissions are supported; That is, there are seperate read/write/execute permissions for file owner,
group and anyone.  This implies the presence of multiple user accounts
and user groups.  Permissions may not be supported on all filesystems.

=item *

The filesystem has a single root

=item *

The C API for the operating system is largely POSIX-compatible

=back

=item *

Apple, DEC, Sun

These include any OS written by, respectively, Apple, DEC, and Sun.
They exist because, while, eg, Mac OS Classic and Mac OS X are very
different platforms, they do support some unique features - such as
AppleScript.  Vendor families may also have similar known issues or
incompatibilities, such as with Sun's 'tar' program.

=item *

MicrosoftWindows

This includes any version of Windows and also includes things like
Cygwin which run on top of it.

=item *

Realtime

This is for all real-time OSes.  So far, it only includes QNX.

=back

=head1 USAGE

No functions are exported by default. The export tag ":all" will export
all functions listed below.

=head2 os_type()

  $os_type = ostype();
  $os_type = ostype('MSWin32');

Returns a single, generic OS type for a given operating system name.  With no
arguments, returns the OS type for the current value of C<$^O>.  If the
operating system is not recognized, the function will return the empty string.

=head2 is_os_type()

  $is_windows = is_os_type('Windows');
  $is_unix    = is_os_type('Unix', 'dragonfly');

Given an OS type and OS name, returns true or false if the OS name is of the
given type.  As with C<os_type>, it will use the current operating system as a
default if no OS name is provided.

=head2 os_family()

  @names = os_family('Apple');

Given an OS family, returns a list of OS names (as they would appear in
C<$^O>) that belong to the given family.  If the family name is not known, the
function will return an empty list.

=head2 is_os_family()

  $is_realtime  = is_os_family('Realtime');
  $is_sun       = is_os_family('Sun', 'solaris');

Given an OS family and an OS name, returns true or false if the OS name is
in the given family.  As with C<os_type>, it will use the current operating
system as a default if no OS name is provided.

=head1 SEE ALSO

=over 4

=item *

L<Devel::CheckOS>

=back

=head1 AUTHOR

David Golden, E<lt>dagolden@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by David Golden

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.0 or,
at your option, any later version of Perl 5 you may have available.

=cut


package OSType;
use strict;
use warnings;

our $VERSION = '0.01';

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw( os_type is_os_type os_family is_os_family );

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
  MicrosoftWindows => [ qw/cygwin MSWin32/ ],
  Realtime => [ qw/qnx/ ],
  Sun => [ qw/solaris sunos/ ],
);

sub os_type {
  return $OSTYPES{ shift || $^O };
}

sub is_os_type {
  my ($type, $os) = @_;
  return unless $type;
  $os ||= $^O;
  return $OSTYPES{$os} eq $type;
}

sub os_family {
  return unless exists $OSFAMILIES{$_[0]};
  return @{ $OSFAMILIES{$_[0]} };
}

sub is_os_family {
  my ($family, $os) = @_;
  return unless exists $OSFAMILIES{$family};
  $os ||= $^O;
  return scalar grep { $_ eq $os } @{ $OSFAMILIES{$family} };
}

1;
__END__

=head1 NAME

OSType - Map operating system names to generic types or families

=head1 SYNOPSIS

  use OSType 'os_type';

  $current_type = os_type();

  $other_type = os_type('dragonfly'); # gives 'Unix'

=head1 DESCRIPTION

Modules that wish to provide OS-specific behaviors often need to know if
a particular operating system

=head2 EXPORT

None by default.



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

David Golden, E<lt>dagolden@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by David Golden

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.0 or,
at your option, any later version of Perl 5 you may have available.

=cut


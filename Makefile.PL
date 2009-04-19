use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'OSType',
    VERSION_FROM      => 'lib/OSType.pm', # finds $VERSION
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/OSType.pm', # retrieve abstract from module
       AUTHOR         => 'David Golden <dagolden@cpan.org>') : ()),
    ( ExtUtils::MakeMaker->VERSION > 6.3001 ?
      (LICENSE        => 'perl') : () ),
);

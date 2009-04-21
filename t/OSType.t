use strict;
use warnings;

use Test::More tests => 37;

use constant NON_EXISTANT_OS => 'titanix'; #the system they said could not go down...
use constant NON_EXISTANT_OS_FAMILY => 'aljfladfk';

#--------------------------------------------------------------------------#
# API tests 
#--------------------------------------------------------------------------#

require_ok( 'OSType' );

can_ok( 'OSType', 'os_type' );

my @functions = qw/os_type os_family is_os_type is_os_family/;
for my $sub ( @functions ) {
  ok( eval { OSType->import($sub); 1 }, "importing $sub()" );
  can_ok( 'main', $sub );
}

my $test_pkg = "testpackage$$";

ok( eval "package $test_pkg; use OSType ':all'; 1", 
  "Testing 'use OSType qw/:all/'"
);

can_ok( $test_pkg, @functions ); 


#--------------------------------------------------------------------------#
# os_type
#--------------------------------------------------------------------------#

{
  ok( my $current_type = os_type(), 'os_type() without arguments' );

  is( $current_type, os_type( $^O ), '... matches os_type($^O)' );

  is(os_type( NON_EXISTANT_OS ), '', 'unknown os_type() returns empty string');

  is(os_type( '' ), '', 'empty string returns empty string');

  is(os_type( undef ), 'Unix', 'resolved operating system from $^O');
}
	
#--------------------------------------------------------------------------#
# is_os_type
#--------------------------------------------------------------------------#

{
  is(is_os_type(NON_EXISTANT_OS), '', 'non-existant operating system');

  is(is_os_type(''), undef, 'empty string returns empty string');

  is(is_os_type('Unix', NON_EXISTANT_OS), '', 'non-existant operating system');

  local $^O = 'VOS';
  ok( ! is_os_type( 'Unix' ), "is_os_type (false)" );
  ok( is_os_type( 'VOS' ),    "is_os_type (true)" );
  ok( ! is_os_type(), "is_os_type (false if no type provided)" );
}


#--------------------------------------------------------------------------#
# os_family
#--------------------------------------------------------------------------#

{
  is(os_family(), undef, 'os_family() without arguments');

  is(os_family(''), undef, 'os_family() without arguments');

  is(os_family(NON_EXISTANT_OS), undef, 'non-existant operating system');
	
  is_deeply( [ sort( os_family('Sun')) ], [ qw/solaris sunos/ ], 
    "os_family (exists)" );
  is_deeply( [ sort( os_family(NON_EXISTANT_OS) ) ], [], "os_family (empty list)" );
  is( my $first = os_family('MicrosoftWindows'), 'MSWin32', 
    'os_family (scalar context)')
}

#--------------------------------------------------------------------------#
# is_os_family
#--------------------------------------------------------------------------#

{
  is(is_os_family(), undef, 'is_os_family() without arguments');

  is(is_os_family(''), undef, 'is_os_family() with empty string');

  local $^O = 'qnx';
  ok( is_os_family('Realtime'), "is_os_family('qnx') is 'Realtime" );
  ok( ! is_os_family('Realtime', 'MSWin32'), 
    "is_os_family('MSWin32') is not 'Realtime" );
  ok( is_os_family('Unix', 'qnx'), "is_os_family('qnx') is 'Unix" );
  ok( ! is_os_family(NON_EXISTANT_OS_FAMILY), "unknown is_os_family()' is false" );
  ok( ! is_os_family(NON_EXISTANT_OS_FAMILY, 'freebsd'), "unknown is_os_family()' is false" );
  ok( ! is_os_family('Unix', NON_EXISTANT_OS), "unknown os argument to is_os_family() is false" );
}

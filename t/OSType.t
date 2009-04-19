use strict;
use warnings;

use Test::More;

plan tests => 25;

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

ok( my $current_type = os_type(), 'os_type() without arguments' );

is( $current_type, os_type( $^O ), '... matches os_type($^O)' );

is( os_type("asdfjkl"), q{}, 'unknown os_type() returns empty string' );

#--------------------------------------------------------------------------#
# is_os_type
#--------------------------------------------------------------------------#

{
  local $^O = 'VOS';
  ok( ! is_os_type( 'Unix' ), "is_os_type (false)" );
  ok( is_os_type( 'VOS' ),    "is_os_type (true)" );
  ok( ! is_os_type(), "is_os_type (false if no type provided)" );
}


#--------------------------------------------------------------------------#
# os_family
#--------------------------------------------------------------------------#

{
  is_deeply( [ sort( os_family('Sun')) ], [ qw/solaris sunos/ ], 
    "os_family (exists)" );
  is_deeply( [ sort( os_family('dfadsf') ) ], [], "os_family (empty list)" );
  is( my $first = os_family('MicrosoftWindows'), 'MSWin32', 
    'os_family (scalar context)')
}

#--------------------------------------------------------------------------#
# is_os_family
#--------------------------------------------------------------------------#

{
  local $^O = 'qnx';
  ok( is_os_family('Realtime'), "is_os_family('qnx') is 'Realtime" );
  ok( ! is_os_family('Realtime', 'MSWin32'), 
    "is_os_family('MSWin32') is not 'Realtime" );
  ok( is_os_family('Unix', 'qnx'), "is_os_family('qnx') is 'Unix" );
  ok( ! is_os_family('aljfladfk'), "unknown is_os_family()' is false" );
}

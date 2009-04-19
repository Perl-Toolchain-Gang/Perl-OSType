use strict;
use warnings;

use Test::More tests => 12;

require_ok( 'OSType' );

can_ok( 'OSType', 'os_type' );

for my $sub ( qw/os_type os_family is_os_type is_os_family/ ) {
  ok( eval { OSType->import($sub); 1 }, "importing $sub()" );
  can_ok( 'main', $sub );
}

ok( my $current_type = os_type(), 'os_type() without arguments' );

is( $current_type, os_type( $^O ), '... matches os_type($^O)' );




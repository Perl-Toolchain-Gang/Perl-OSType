use strict;
use warnings;

use Test::More tests => 28;
use Test::Exception;

require_ok( 'OSType' );

can_ok( 'OSType', 'os_type' );

for my $sub ( qw/os_type os_family is_os_type is_os_family/ ) {
  ok( eval { OSType->import($sub); 1 }, "importing $sub()" );
  can_ok( 'main', $sub );
}

ok( my $current_type = os_type(), 'os_type() without arguments' );

is( $current_type, os_type( $^O ), '... matches os_type($^O)' );

is(os_type( 'titanix' ), undef, 'the system they said could not go down...');

is(os_type( '' ), '', 'default');

is(os_type( undef ), 'Unix', 'default');

is(is_os_type(), undef);

is(is_os_type('titanix'), '');

is(is_os_type('Unix', 'titanix'), '', 'non-existant operating system');

is(is_os_type('Unix', 'freebsd'), 1, 'valid call');

is(os_family(), undef, 'os_family() without arguments');

is(os_family('titanix'), undef, 'non-existant operating system');

is(os_family('Unix'), 32, '');

is(is_os_family(), undef, 'is_os_family() without arguments');

is(is_os_family('Unix', 'titanix'), 0, 'non-existant operating system');

is(is_os_family('Unix', 'freebsd'), 1, 'valid call');

is(is_os_family('DUMMY', 'freebsd'), undef, 'dummy family');

is(is_os_family('DUMMY'), undef, 'missing operating system');

is(is_os_family('Unix'), 1, 'missing operating system');

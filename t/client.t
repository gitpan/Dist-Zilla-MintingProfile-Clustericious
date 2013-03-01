use strict;
use warnings;
use Test::More tests => 1;
use Test::DZil;
use Path::Class qw( file dir );
use FindBin ();

$ENV{DIST_ZILLA_MINTING_PROFILE_CLUSTERICIOUS} = dir($FindBin::Bin)->parent->subdir('share')->stringify;

my $tzil = Minter->_new_from_profile(
  [ Clustericious => 'client' ],
  { name => 'Foo-Client' },
  { global_config_root => dir('corpus/global')->absolute },
);

$tzil->mint_dist;

like $tzil->slurp_file('mint/lib/Foo/Client.pm'), qr{^package Foo::Client;}, "package Foo";

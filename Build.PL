
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "FindBin" => 0,
    "Module::Build" => "0.3601",
    "Test::DZil" => 0,
    "Test::More" => 0
  },
  "configure_requires" => {
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "Minting profile for Clustericious clients and servers",
  "dist_author" => [
    "Graham Ollis <plicease\@cpan.org>"
  ],
  "dist_name" => "Dist-Zilla-MintingProfile-Clustericious",
  "dist_version" => "0.01",
  "license" => "perl",
  "module_name" => "Dist::Zilla::MintingProfile::Clustericious",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "Dist::Zilla::File::InMemory" => 0,
    "Dist::Zilla::Plugin::ModuleBuildDatabase" => 0,
    "Dist::Zilla::Plugin::OurPkgVersion" => 0,
    "Dist::Zilla::Plugin::PodWeaver" => 0,
    "Dist::Zilla::Role::MintingProfile" => 0,
    "Dist::Zilla::Role::ModuleMaker" => 0,
    "File::ShareDir" => 0,
    "Mojo::Template" => 0,
    "Moose" => 0,
    "Path::Class" => 0,
    "namespace::autoclean" => 0,
    "perl" => "v5.10.0"
  },
  "script_files" => [],
  "share_dir" => {
    "dist" => "share"
  }
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;

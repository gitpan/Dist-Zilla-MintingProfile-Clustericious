package Dist::Zilla::Plugin::Clustericious::Mint;

# ABSTRACT: Generate new Clustericious dist from templates
our $VERSION = '0.01'; # VERSION


use Moose;
use v5.10;
use Dist::Zilla::File::InMemory;
use Mojo::Template;
use Dist::Zilla::MintingProfile::Clustericious;

with 'Dist::Zilla::Role::ModuleMaker';

use namespace::autoclean;

has type => (
  is       => 'ro',
  isa      => 'Str',
  required => 1,
);

sub _recurse
{
  my($self, $class, $srcdir, $destdir) = @_;
  
  foreach my $child ($srcdir->children)
  {
    my $dest = join '/', $destdir, do {
      my $base = $child->basename;
      
      $base =~ s/APPCLASS/$class/eg;

      my $path = $class;
      $path =~ s/::/\//g;
      $base =~ s/APPPATH/$path/eg;
      
      my $name = lc $class;
      $name =~ s/::/_/g;
      $base =~ s/APPNAME/$name/eg;
      
      $base;
    };
    if($child->is_dir)
    {
      $self->_recurse($class, $child, $dest);
    }
    else
    {
      my $file = Dist::Zilla::File::InMemory->new(
        name    => $dest,
        mode    => $dest =~ m{^/bin/} ? 0755 : 0644,
        content => do {
          my $txt = Mojo::Template->new(name => $child->stringify)->render(
            '% my $class = "' . $class . "\";\n" .
            $child->slurp
          );
          die $txt if ref $txt;
          $txt;
        },
      );
      $self->zilla->log("adding $dest");
      $self->add_file($file);
    }
  }
}

sub make_module
{
  my($self, $args) = @_;

  my $class = $args->{name};
  if($self->type eq 'client')
  {
    unless($class =~ /::Client$/)
    {
      die "client dist name should end in ::Client";
    }
    $class =~ s/::Client$//;
  }

  my $dir = $self->zilla->root->subdir('template');
  
  unless(-d $dir)
  {
    $dir = Dist::Zilla::MintingProfile::Clustericious
      ->profile_dir($self->type)
      ->subdir('template');
  }
  
  $self->_recurse(
    $class, 
    $dir,
    '',
  );
  
  return;
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=pod

=head1 NAME

Dist::Zilla::Plugin::Clustericious::Mint - Generate new Clustericious dist from templates

=head1 VERSION

version 0.01

=head1 DESCRIPTION

This module is not usually used directly.  Instead see the
C<Clustericious> minting profile.

=head1 SEE ALSO

L<Dist::Zilla::MintingProfile::Clustericious>

=head1 AUTHOR

Graham Ollis <plicease@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by NASA GSFC.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

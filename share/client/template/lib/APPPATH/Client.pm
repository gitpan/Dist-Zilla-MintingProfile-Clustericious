package <%= $class %>::Client;

# ABSTRACT: <%= $class %> Client
# VERSION

=head1 SYNOPSIS

 my $c = <%= $class %>::Client->new();
 my $msg = $c->welcome or die $c->errorstring;

=cut

use strict;
use warnings;
use Clustericious::Client;

=head1 METHODS

=head2 welcome

Get a welcome message.

=head3 Arguments

=over 4

=item * verbose

be verbose

=back

=cut

route 'welcome'   => 'GET', '/';
route_args 'welcome' => [
    { name => 'verbose', type => '=s', modifies_url => 'query' },
];

=head1 SEE ALSO

% my $name = lc $class;
% $name =~ s/::/_/g;
L<<%= $name.'client' %>>

=cut

1;


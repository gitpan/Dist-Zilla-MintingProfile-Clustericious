package <%= $class %>::Routes;

# ABSTRACT: Set up routes for <%= $class %>
# VERSION

=head1 DESCRIPTION

This package defines the REST API for <%= $class %>.

=cut

use strict;
use warnings;
use Clustericious::RouteBuilder;

=head1 ROUTES

head2 get /

Get a welcome message.

=cut

get '/' => sub { shift->render_text("welcome to <%= $class %>") };

1;

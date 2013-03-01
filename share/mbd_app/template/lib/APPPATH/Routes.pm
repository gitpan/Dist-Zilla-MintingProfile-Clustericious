package <%= $class %>::Routes;

# ABSTRACT: Set up routes for <%= $class %>
# VERSION

=head1 DESCRIPTION

This package defines the REST API for <%= $class %>.

=cut

use strict;
use warnings;
use <%= $class %>::Objects;
use Clustericious::RouteBuilder;
use Clustericious::RouteBuilder::CRUD
        "create" => { -as => "do_create" },
        "read"   => { -as => "do_read"   },
        "delete" => { -as => "do_delete" },
        "update" => { -as => "do_update" },
        "list"   => { -as => "do_list"   },
        defaults => { finder => "Rose::Planter" };
use Clustericious::RouteBuilder::Search
        "search" => { -as => "do_search" },
        defaults => { finder => "Rose::Planter" };

get   '/' => sub {shift->render_text("welcome to <%= $class %>")};

post  '/:items/search' => \&do_search;
get   '/:items/search' => \&do_search;
post  '/:table'        => [ table => Rose::Planter->regex_for_tables ] => \&do_create;
get   '/:table/*key'   => [ table => Rose::Planter->regex_for_tables ] => \&do_read;
post  '/:table/*key'   => [ table => Rose::Planter->regex_for_tables ] => \&do_update;
del   '/:table/*key'   => [ table => Rose::Planter->regex_for_tables ] => \&do_delete;
get   '/:table'        => [ table => Rose::Planter->regex_for_tables ] => \&do_list;

1;

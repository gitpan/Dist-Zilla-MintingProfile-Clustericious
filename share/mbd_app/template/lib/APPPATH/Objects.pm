package <%= $class %>::Objects;

# ABSTRACT: All model classes for <%= $class %>
# VERSION

=head1 DESCRIPTION

Use this package to load all the <%= $class %>::Object::* classes.

=cut

use strict;
use warnings;
use <%= $class %>::DB;
use Rose::Planter
        loader_params => {
            class_prefix => "<%= $class %>::Object",
            db_class     => "<%= $class %>::DB",
        },
        convention_manager_params => {};
1;

use utf8;
package Schema::Result::SlidesPosition;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Result::SlidesPosition

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<slides_positions>

=cut

__PACKAGE__->table("slides_positions");

=head1 ACCESSORS

=head2 slide_id

  data_type: 'integer'
  is_nullable: 0

=head2 position_id

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "slide_id",
  { data_type => "integer", is_nullable => 0 },
  "position_id",
  { data_type => "integer", is_nullable => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2012-06-09 19:28:42
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:MkqgjzAQg9yzJdBQpRWHog


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

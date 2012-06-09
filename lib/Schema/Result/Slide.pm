use utf8;
package Schema::Result::Slide;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Result::Slide

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<slides>

=cut

__PACKAGE__->table("slides");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 presentation_id

  data_type: 'integer'
  is_nullable: 0

=head2 content

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "presentation_id",
  { data_type => "integer", is_nullable => 0 },
  "content",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2012-06-09 19:28:42
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:q8+pe5ZNG8Z6L8+ctUbMzA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

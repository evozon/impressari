use utf8;
package Schema::Result::Position;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Result::Position

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<positions>

=cut

__PACKAGE__->table("positions");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 x

  data_type: 'integer'
  is_nullable: 0

=head2 y

  data_type: 'integer'
  is_nullable: 0

=head2 z

  data_type: 'integer'
  is_nullable: 0

=head2 rotate

  data_type: 'integer'
  is_nullable: 0

=head2 rotatex

  data_type: 'integer'
  is_nullable: 0

=head2 rotatey

  data_type: 'integer'
  is_nullable: 0

=head2 rotatez

  data_type: 'integer'
  is_nullable: 0

=head2 scale

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "x",
  { data_type => "integer", is_nullable => 0 },
  "y",
  { data_type => "integer", is_nullable => 0 },
  "z",
  { data_type => "integer", is_nullable => 0 },
  "rotate",
  { data_type => "integer", is_nullable => 0 },
  "rotatex",
  { data_type => "integer", is_nullable => 0 },
  "rotatey",
  { data_type => "integer", is_nullable => 0 },
  "rotatez",
  { data_type => "integer", is_nullable => 0 },
  "scale",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2012-06-09 19:28:42
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:jybEMNgAtHmimIHYomLZBw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

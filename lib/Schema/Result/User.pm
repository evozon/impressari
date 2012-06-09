use utf8;
package Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Result::User

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<users>

=cut

__PACKAGE__->table("users");

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0

=head2 email

  data_type: 'text'
  is_nullable: 0

=head2 password

  data_type: 'varchar'
  is_nullable: 0
  size: 100

=head2 first_name

  data_type: 'varchar'
  is_nullable: 0
  size: 100

=head2 last_name

  data_type: 'varchar'
  is_nullable: 0
  size: 100

=head2 genre

  data_type: 'varchar'
  is_nullable: 0
  size: 20

=head2 type

  data_type: 'varchar'
  default_value: 'user'
  is_nullable: 0
  size: 20

=head2 active

  data_type: 'tinyint'
  default_value: 0
  is_nullable: 0

=head2 lastupdate

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "bigint", is_auto_increment => 1, is_nullable => 0 },
  "email",
  { data_type => "text", is_nullable => 0 },
  "password",
  { data_type => "varchar", is_nullable => 0, size => 100 },
  "first_name",
  { data_type => "varchar", is_nullable => 0, size => 100 },
  "last_name",
  { data_type => "varchar", is_nullable => 0, size => 100 },
  "genre",
  { data_type => "varchar", is_nullable => 0, size => 20 },
  "type",
  {
    data_type => "varchar",
    default_value => "user",
    is_nullable => 0,
    size => 20,
  },
  "active",
  { data_type => "tinyint", default_value => 0, is_nullable => 0 },
  "lastupdate",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2012-06-09 19:28:42
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:OQc3If/C8o2IJ4GMphNKeg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

package Impressari::Models::Base;

use strict;
use warnings;

use base 'Class::DBI::mysql';

__PACKAGE__->connection('dbi:mysql:database=impressari;host=localhost', 'root', '');

1;
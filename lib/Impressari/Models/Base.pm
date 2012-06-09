package Impressari::Models::Base;

use strict;
use warnings;

use base 'Class::DBI::mysql';

__PACKAGE__->connection('dbi:mysql:database=impressari;host=192.168.2.108', 'impressari', 'impressari');

1;
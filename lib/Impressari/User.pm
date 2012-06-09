package Impressari::User;

use strict;
use warnings;

use Mojo::Base 'Mojolicious::Controller';
use DateTime;
use YAML::Tiny;
use DateTime::Format::Strptime;
use Data::Dumper;


sub login {
    my $self = shift;
    my ($email, $pass) = @_;
    
    my $schema = $self->app->model;
    my $user = undef;
    
    $user = $schema->resultset('User')->find(
        {
            email    => $email,
            password => $pass,
        }
    );
    
    if ($user){
        $self->session->{user} = $user;
        $self->redirect_to('/');
    }
}

sub authorized {
    my $self = shift;
    
    if ($self->session->{user}){
        #return true value
        1;    
    } else {
        #redirect to login page
        $self->redirect_to('/login');
        0;
    }
}

1;
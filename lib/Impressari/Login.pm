package Impressari::Login;

use strict;
use warnings;

use base 'Impressari::Base';

use Impressari::Models::Login;

use Email::Valid;
use Digest::MD5 qw(md5_hex);
use MIME::Lite;
use DateTime;

use Data::Dumper;

sub all{
    my $self = shift;
    my $users;
    
    #we've got search criteria
    if ($self->param('q')){
        #look up for users that meet criteria
        $users = Impressari::Models::Users->search_where(
            {
                '-or' => {
                    first_name => {'like', '%'.$self->param('q').'%'},
                    last_name => {'like', '%'.$self->param('q').'%'}
                }
            },
            {order_by => "type asc, first_name asc"}
        );   
    }#no search criteria
    else {
        #retrieve all artists
        $users = Impressari::Models::Users->search_where(
            {id => { '!=', '0' }},
            {
                order_by => "type asc, first_name asc",
                #limit_dialect => 'LimitOffset',
                #limit => 10
            });
    }
    
    $self->render(
        users => $users
    );
}

sub register{
    my $self = shift;
    
    #retrieve genres - needed in search dropdown
    my $genres = Impressari::Models::Genres->retrieve_all;
    $self->stash(genres => $genres);

    my $validator;
    
    #register action required
    if ($self->param('register')){
        $validator = $self->__validate($self->param());
        
        return $self->render(validator => $validator) if $validator;
        
        my $user = Impressari::Models::Users->find_or_create({
            email => $self->param('email'),
            password => (md5_hex $self->param('password')),
            first_name => $self->param('first_name'),
            last_name => $self->param('last_name'),
            genre => $self->param('genre')
        });
        
        my $inactive_user = Impressari::Models::InactiveUsers->find_or_create({
            user_id => $user->id,
            secret_key => (md5_hex (DateTime->now->strftime("%Y_%m_%d_%H_%M_%S_").$user->email))
        });
        
        $self->session(data => undef);
        
        warn "Activation link : http://localhost:3000/users/activate/".$inactive_user->user_id."/".$inactive_user->secret_key;
        
        #send email
        #my $msg = MIME::Lite->new(
        #    From    => 'users@Impressari.com',
        #    To      => $self->session('User_email'),
        #    Subject => 'Your activation link',
        #    Type    => 'TEXT',
        #    Data    => "Activation link : http://localhost:3000/users/activate/".$inactive_user->user_id."/".$inactive_user->secret_key
        #);
        #
        #MIME::Lite->send('smtp', '127.0.0.1', Timeout => 10);
        #$msg->send; 
        $self->redirect_to('/register/success');   
    }
    
    $self->render(validator => $validator);
}

sub __validate{
    my $self = shift;
    
    my $valid = undef;
    my $validator = {
        email => '',
        'password' => '',
        'password_confirm' => ''
    };
    
    #valid email address
    if  (Email::Valid->address($self->param('email'))){
        #lookup for a user with given email address
        my $user = Impressari::Models::Users->retrieve(email => $self->param('email'));
        
        if ($user){
            $validator->{email} = 'Already have a user with this e-mail';    
            $valid = 1;
        }
    }#invalid email address
    else{
        $validator->{email} = 'Invalid email format';
        $valid = 1;
    }
    
    if (length($self->param('password')) < 6){
        $validator->{password} = 'Password must be a minimum of 6 characters';
        $valid = 1;
    }elsif ($self->param('password') ne $self->param('password_confirm')){
        $validator->{password_confirm} = 'Passwords do not match';
        $valid = 1;
    }
    
    #store params to session (don't lose form input data)
    my $data;
    foreach my $key ($self->param()){
        $data->{Users}->{$key} = $self->param($key);
    }
    
    $self->session(data => $data);
    
    #validation not passed
    return $validator if ($valid);
    
    #validation passed
    return $valid;
}

#success : just display the register success view
sub success{}

sub activate{
    my $self = shift;
    
    #retrieve user with given id, from inactive users
    my $inactive = Impressari::Models::InactiveUsers->retrieve(
            user_id => $self->param('user_id'),
            secret_key => $self->param('secret_key')
            
        );
    
    #valid user_id and secret_key combination
    if ($inactive){
        my $user = $inactive->user_id;
        
        #set user active
        $user->set(active => '1');
        #store changes to db
        $user->update();
        
        #delete line from inactive users
        $inactive->delete();
        
        #login user
        $self->__login($user);
            
        #and redirect to home page
        $self->redirect_to('/favorites');   
    }
    
    #invalid combination, redirect to home page
    $self->redirect_to('/');
}

sub login{
    my $self = shift;
    
    #redirect to home page if user alredy logged in
    $self->redirect_to('/') if ($self->session('User_id'));
    
    #login action
    if ($self->param('login')){
        my $user = Impressari::Models::Users->retrieve(
            email => $self->param('email'),
            password => (md5_hex $self->param('password'))
        );
        
        if ($user && $user->active eq '1'){
            my $user_type = $self->__login($user);
            
            if ($user_type eq 'admin'){
                $self->redirect_to('/users/all');
            }else{
                $self->redirect_to('/favorites');   
            }
        }elsif ($user->active ne '1'){
            $self->render(
                error => 'User is inactive'
            );     
        }else{
            $self->render(
                error => 'Invalid username/password'
            );   
        }    
    }else{
        $self->render(
            error => 0
        );
    }
}

#__login : store given user in session
sub __login{
    my ($self, $user) = @_;
    
    #store user in session
    $self->session(User_id => $user->id);
    $self->session(User_email => $user->email);
    $self->session(User_first_name => $user->first_name);
    $self->session(User_last_name => $user->last_name);
    $self->session(User_type => $user->type);
    
    warn $user->email." logged in\n";
    
    #and return user type
    return $user->type;
}

sub logout{
    my $self = shift;
    
    warn $self->session('User_email')." logged out\n";
    
    $self->session('User_id' => 0);
    $self->session(User_email => undef);
    $self->session(User_first_name => undef);
    $self->session(User_last_name => undef);
    $self->session(User_type => undef);
            
    $self->redirect_to('/');
}

sub check {
    my $self = shift;
    
    #retrieve user stored in session
    my $user = Impressari::Models::Users->retrieve($self->session('User_id'));
    my $type = $self->param('type');
    
    #user is valid
    if ($user && ($user->email eq $self->session('User_email'))){
        #type is required and user is that type
        if ($type && $user->type eq $type){
            #return true value
            1;   
        }#type is not required
        elsif (!$type){
            #return true value
            1;    
        }
        elsif ($type && $user->type ne $type){
            #redirect to login page
            $self->redirect_to('/login');     
        }
    }#user is invalid
    else{
        #redirect to login page
        $self->redirect_to('/login');
        0;
    }
}

sub delete{
    my $self = shift;
    
    #delete the user with given id
    Impressari::Models::Users->search(id => $self->param('id'))->delete_all();
    
    #and redirect to users page
    $self->redirect_to('/users/all');
}

1;
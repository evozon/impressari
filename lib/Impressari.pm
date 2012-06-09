package Impressari;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer');
  
  # Everything can be customized with options
  my $config = $self->plugin( yaml_config => {
        file      => 'conf/config.yaml',
        stash_key => 'conf',
        class     => 'YAML::XS'
  });
                                
  $self->{config} = $config;
  
  if (!$self->can('model')) {
      __PACKAGE__->attr(
       'model' => sub {
              Schema->connect(
                  $config->{database}->{db_name},  
                  $config->{database}->{user},
                  $config->{database}->{pass},
              );
          }
      );
  }
  
  # Router
  my $public = $self->routes;

  # Normal route to controller
  $public->get('/')->to('main#home')->name('HOME');
  $public->route('/logout')->to('user#logout')->name('logout');
  $public->route('/login')->via('GET')->to('user#login_form')->name('login_form');
  $public->route('/login')->via('POST')->to('user#login')->name('login');
}

1;

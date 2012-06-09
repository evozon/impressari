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
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('login#login');
}

1;

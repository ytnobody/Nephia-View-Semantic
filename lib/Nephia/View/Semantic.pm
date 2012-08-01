package Nephia::View::Semantic;
use strict;
use warnings;
use parent 'Template::Semantic';
use FindBin;
use File::Spec;
our $VERSION = '0.01';

sub new {
    my ( $class, %opts ) = @_;
    my $template_path = delete $opts{path} || File::Spec->catdir( $FindBin::Bin, 'view' );
    my $self = $class->SUPER::new( %opts ); 
    $self->{template_path} = $template_path;
    return $self;
}

sub render {
    my ( $self, $template, $data ) = @_;
    my $injection_data;
    if ( ref $template eq 'ARRAY' ) {
        my $injection = ref $template->[1] eq 'HASH' ? 
            $template->[1] : 
            do(File::Spec->catfile($self->{template_path}, $template->[1]))
        ;
        $template = $template->[0];
        $injection_data = {};
        for my $key ( keys %$injection ) {
            my $target = $injection->{$key};
            my $injection_code;
            if ( ref $target eq 'ARRAY' ) {
                ( $target, $injection_code ) = @$target;
            }
            $injection_data->{$target} = $injection_code ?
                [ map { $injection_code->($_) } @{$data->{$key}} ] :
                $data->{$key}
            ;
        }
    }
    $template = File::Spec->catfile( $self->{template_path}, $template );
    $injection_data ||= $data;
    return $self->process( $template, $injection_data );
}

1;
__END__

=head1 NAME

Nephia::View::Semantic - view class for Nephia

=head1 SYNOPSIS

  # in your app-class ..
  package MyApp;
  use Nephia;
  
  # and your app.psgi ..
  use MyApp;
  MyApp->run( view => {
      class => 'Semantic',
      path => './view',
  } );

=head1 DESCRIPTION

Nephia::View::Semantic is a view class for Nephia that using Template::Semantic.

=head1 USING IN SETUP

  nephia-setup Your::AppName --flavor View::Semantic

=head1 HOW TO FILLING IN DATA TO TEMPLATE

=head2 BASIC WAY

Specify template and data(with DOM-selector).

  path "/" => sub {
      return {
          template => 'index.html',
          'title, h1#title' => 'Welcome to my homepage!', 
      };
  };

=head2 SPECIFY INJECTION-RULE

You may specify a injection-rule when specify a template.

  path "/" => sub {
      return {
          template => [ 
              'index.html', 
              { appname => 'title, h1#title' }, 
          ],
          appname => 'My Homepage',
      };
  };

=head2 SPECIFY A FILE THAT CONTAINS INJECTION-RULE

You may specify a file that contains injection-rule when specify a template.

  # in your applicaton
  path "/" => sub {
      return {
          template => [ 
              'index.html', 
              'injection/index.pl', 
          ],
          appname => 'My Homepage',
      };
  };
  
  # view/injection/index.pl is here.
  { appname => 'title, h1#title' };

=head1 INJECTION-RULE

As mentioned, you may use injection-rule for specify data-filling.

=head2 LOOP IN INJECTION-RULE

You may specify processing for loop with injection-rule.

  # in your application
  path "/" => sub {
     return {
         template => [
             'index.html',
             {
                 items => [
                     'ul li',
                     sub { { a => $_->{name}, href => $_->{url} }
                 ],
             }
         ]
         items => [ 
             { name => 'foo', url => 'http://example.com/1st' },
             { name => 'bar', url => 'http://example.com/2nd' },
             { name => 'baz', url => 'http://example.com/3rd' },
         ],
     };
  };
  
  # in index.html
  <html>
  <body>
    <ul>
      <li><a href="#"></a></li>
    </ul>
  </body>
  </html>
  
  # will be ...
  <html>
  <body>
    <ul>
      <li><a href="http://example.com/1st">foo</a></li>
      <li><a href="http://example.com/2nd">bar</a></li>
      <li><a href="http://example.com/3rd">baz</a></li>
    </ul>
  </body>
  </html>

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

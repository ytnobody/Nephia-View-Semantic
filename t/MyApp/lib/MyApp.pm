package MyApp;
use strict;
use warnings;
use Nephia;

our $VERSION = 0.01;

path '/' => sub {
    return {
        template => 'index.html',
        title => 'MyApp',
        h1 => 'MyApp',
    };
};

path '/injection/hash' => sub {
    return {
        template => [ 'index.html', { 
            appname => 'title, h1', 
            items => [ 'ul', sub { { li => $_ } } ],
        } ],
        appname => 'MyApp',
        items => [ qw[ hoge fuga ] ],
    };
};

path '/injection/file' => sub {
    return {
        template => [ 'index.html', 'injection/index.pl' ],
        appname => 'MyApp',
        items => [ qw[ foo bar baz ] ],
    };
};

1;
__END__

=head1 NAME

MyApp - Web Application

=head1 SYNOPSIS

  $ plackup

=head1 DESCRIPTION

MyApp is web application based Nephia.

=head1 AUTHOR

clever guy

=head1 SEE ALSO

Nephia

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

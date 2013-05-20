# NAME

Nephia::View::Semantic - view class for Nephia

# SYNOPSIS

    # in your app-class ..
    package MyApp;
    use Nephia;
    

    # and your app.psgi ..
    use MyApp;
    MyApp->run( view => {
        class => 'Semantic',
        path => './view',
    } );

# DESCRIPTION

Nephia::View::Semantic is a view class for Nephia that using Template::Semantic.

# USING IN SETUP

    nephia-setup Your::AppName --flavor View::Semantic

# HOW TO FILLING IN DATA TO TEMPLATE

## BASIC WAY

Specify template and data(with DOM-selector).

    path "/" => sub {
        return {
            template => 'index.html',
            'title, h1#title' => 'Welcome to my homepage!', 
        };
    };

## SPECIFY INJECTION-RULE

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

## SPECIFY A FILE THAT CONTAINS INJECTION-RULE

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

# INJECTION-RULE

As mentioned, you may use injection-rule for specify data-filling.

## LOOP IN INJECTION-RULE

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

# AUTHOR

ytnobody <ytnobody@gmail.com>

# SEE ALSO

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

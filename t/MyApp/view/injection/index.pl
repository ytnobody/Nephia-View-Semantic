{ 
    appname => 'title, h1',
    items => [ 
        'ul li', 
        sub { { a => $_, 'a@href' => './'.$_ } },
    ],
};

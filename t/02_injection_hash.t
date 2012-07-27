use strict;
use warnings;
use Test::More;
use Plack::Test;
use HTTP::Request::Common;
use FindBin;
use lib ("$FindBin::Bin/MyApp/lib");
use MyApp;

test_psgi
    app => MyApp->run( view => {
        class => 'Semantic',
        path => "$FindBin::Bin/MyApp/view",
    } ),
    client => sub {
        my $cb = shift;
        my $res = $cb->(GET "/injection/hash");
        is $res->code, 200;
        like $res->content, qr{<h1>MyApp</h1>};
        like $res->content, qr{<li>hoge</li>};
        like $res->content, qr{<li>fuga</li>};
    }
;

done_testing;

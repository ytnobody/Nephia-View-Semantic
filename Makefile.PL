use inc::Module::Install;
name 'Nephia-View-Semantic';
all_from 'lib/Nephia/View/Semantic.pm';

requires 'Nephia';
requires 'Template::Semantic';
requires 'File::Spec';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
test_requires 'HTTP::Request::Common';
auto_set_repository;
auto_include;
WriteAll;

use inc::Module::Install;
name 'Nephia-View-Semantic';
all_from 'lib/Nephia/View/Semantic.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;

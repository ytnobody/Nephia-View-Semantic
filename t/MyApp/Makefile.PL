use inc::Module::Install;
all_from 'lib/MyApp.pm';

requires 'Nephia' => 0.01;

tests 't/*.t';

test_requires 'Test::More';

WriteAll;

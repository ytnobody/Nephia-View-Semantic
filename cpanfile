requires 'File::Spec';
requires 'Nephia';
requires 'Template::Semantic';

on build => sub {
    requires 'ExtUtils::MakeMaker', '6.36';
};

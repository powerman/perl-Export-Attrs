use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Export::Attrs',
    license             => 'perl',
    dist_author         => 'Damian Conway <DCONWAY@cpan.org>',
    dist_version_from   => 'lib/Export/Attrs.pm',
    requires => {
        'Test::More' => 0,
        'version'    => 0,
        'Attribute::Handlers' => 0,
    },
    add_to_cleanup      => [ 'Export-Attrs-*' ],
);

$builder->create_build_script();

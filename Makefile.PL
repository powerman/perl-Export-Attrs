use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Export::Attrs',
    AUTHOR              => 'Damian Conway <DCONWAY@cpan.org>',
    VERSION_FROM        => 'lib/Export/Attrs.pm',
    ABSTRACT_FROM       => 'lib/Export/Attrs.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More'          => 0,
        'version'             => 0,
        'Attribute::Handlers' => 0,
        'PadWalker'           => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Export-Attrs-*' },
);

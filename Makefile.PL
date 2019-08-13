use strict;
use warnings;
use ExtUtils::MakeMaker;

# eval q{
#     use File::ShareDir::Install 0.07;
#     delete_share '.'; # delete it all first
#     install_share 'share'; # install the current version second
#     *MY::postamble = \&File::ShareDir::Install::postamble;
# };
# warn "-- share/ will not be installed --\n\t$@\n-- end sharedir error --\n" if $@;

WriteMakefile(
    NAME             => 'Perl::Phase',
    AUTHOR           => 'Daniel Muey <http://drmuey.com/cpan_contact.pl>',
    VERSION_FROM     => 'lib/Perl/Phase.pm',
    ABSTRACT_FROM    => 'lib/Perl/Phase.pm',
    MIN_PERL_VERSION => "5.014",
    PL_FILES         => {},
    PREREQ_PM        => {
        'Test::More' => 0,
        'Test::Spec' => 0,
        XSLoader     => 0,
    },
    META_MERGE => {
        resources => {
            repository => q[https://github.com/drmuey/p5-Perl-Phase.git],
            bugtracker => q[https://github.com/drmuey/p5-Perl-Phase/issues],
            keywords   => [ 'perl', 'global', 'phase', ],
        },
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES    => 'Perl-Phase-*' },
);

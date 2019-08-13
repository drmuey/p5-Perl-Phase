use Test::Spec;
use Perl::Phase;

diag("Testing Perl::Phase $Perl::Phase::VERSION");

describe "Perl::Phase function" => sub {
    describe "run time function" => sub {
        describe "is_run_time()" => sub {
            it "should be true during INIT" => sub {
                local *Perl::Phase::current_phase = sub { Perl::Phase::PERL_PHASE_INIT };
                ok is_run_time();
            };

            it "should be true during RUN" => sub {
                local *Perl::Phase::current_phase = sub { Perl::Phase::PERL_PHASE_RUN };
                ok is_run_time();
            };

            it "should be true during END" => sub {
                local *Perl::Phase::current_phase = sub { Perl::Phase::PERL_PHASE_END };
                ok is_run_time();
            };

            it "should be true during DESTRUCT" => sub {
                local *Perl::Phase::current_phase = sub { Perl::Phase::PERL_PHASE_DESTRUCT };
                ok is_run_time();
            };

            it "should be false during CONSTRUCT" => sub {
                local *Perl::Phase::current_phase = sub { Perl::Phase::PERL_PHASE_CONSTRUCT };
                ok !is_run_time();
            };

            it "should be false during START" => sub {
                local *Perl::Phase::current_phase = sub { Perl::Phase::PERL_PHASE_START };
                ok !is_run_time();
            };
            it "should be false during CHECK" => sub {
                local *Perl::Phase::current_phase = sub { Perl::Phase::PERL_PHASE_CHECK };
                ok !is_run_time();
            };
        };

        describe "assert_is_run_time()" => sub {
            it "should not die during run time" => sub {
                no warnings "redefine";
                local *Perl::Phase::is_run_time = sub { 1 };
                trap { Perl::Phase::assert_is_run_time() };
                is $trap->die, undef;

            };
            it "should die during compile time" => sub {
                no warnings "redefine";
                local *Perl::Phase::is_run_time = sub { 0 };
                trap { Perl::Phase::assert_is_run_time() };
                like $trap->die, qr/at compile time/;
            };
        };
    };

    describe "compile time function" => sub {
        describe "is_compile_time()" => sub {
            it "should be true during CONSTRUCT" => sub {
                local *Perl::Phase::current_phase = sub { Perl::Phase::PERL_PHASE_CONSTRUCT };
                ok is_compile_time();
            };

            it "should be true during START" => sub {
                local *Perl::Phase::current_phase = sub { Perl::Phase::PERL_PHASE_START };
                ok is_compile_time();
            };
            it "should be true during CHECK" => sub {
                local *Perl::Phase::current_phase = sub { Perl::Phase::PERL_PHASE_CHECK };
                ok is_compile_time();
            };

            it "should be false during INIT" => sub {
                local *Perl::Phase::current_phase = sub { Perl::Phase::PERL_PHASE_INIT };
                ok !is_compile_time();
            };

            it "should be false during RUN" => sub {
                local *Perl::Phase::current_phase = sub { Perl::Phase::PERL_PHASE_RUN };
                ok !is_compile_time();
            };

            it "should be false during END" => sub {
                local *Perl::Phase::current_phase = sub { Perl::Phase::PERL_PHASE_END };
                ok !is_compile_time();
            };

            it "should be true during DESTRUCT" => sub {
                local *Perl::Phase::current_phase = sub { Perl::Phase::PERL_PHASE_DESTRUCT };
                ok !is_compile_time();
            };
        };

        describe "assert_is_compile_time()" => sub {
            it "should not die during compile time" => sub {
                no warnings "redefine";
                local *Perl::Phase::is_compile_time = sub { 1 };
                trap { Perl::Phase::assert_is_compile_time() };
                is $trap->die, undef;

            };
            it "should die during compile time" => sub {
                no warnings "redefine";
                local *Perl::Phase::is_compile_time = sub { 0 };
                trap { Perl::Phase::assert_is_compile_time() };
                like $trap->die, qr/at run time/;
            };
        };
    };
};

runtests unless caller;

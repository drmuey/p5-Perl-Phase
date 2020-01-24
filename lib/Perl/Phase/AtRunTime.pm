package Perl::Phase::AtRunTime;

use strict;
use warnings;

sub import {
    my ( $class, @runtime_calls ) = @_;

    my $caller = caller();
    for my $rt_call (@runtime_calls) {
        eval qq{
            package $caller {
                { # for use()
                   no warnings; ## no critic qw(TestingAndDebugging::ProhibitNoWarnings)
                   INIT { 
                      \$rt_call->() 
                   }
                }

                # for require(), when its too late to run INIT
                \$rt_call->() if \${^GLOBAL_PHASE} eq 'RUN';
            };
        };
    }

    return;
}

1;

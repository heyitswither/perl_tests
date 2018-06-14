#!/usr/bin/env perl
use strict;
use warnings;
use diagnostics;

sub isprime {
    my $n = shift;
    for (2...$n/2) {
        return 0 if !($n % $_);
    }
    return 1;
}

for (2...100) {
    print "$_\n" if isprime $_;
}

#!/usr/bin/env perl
use strict;
use warnings;
use diagnostics;

for (1...100) {
    print "Fizz" x !($_ % 3);
    print "Buzz" x !($_ % 5);
    print "$_" x !!($_ % 3 and $_ % 5);
    print "\n";
}

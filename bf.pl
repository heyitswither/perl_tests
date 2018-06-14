#!/usr/bin/env perl
use strict;
use warnings;
use diagnostics;

sub exec_bf {
    my $file = shift;
    my @array = (0) * 256;
    my $ptr = 0;
    open(FILE, "<".$file) or die "Unable to open file: ".$file;
    while(<FILE>) {
        foreach my $c (split(//, $_)) {
            $ptr++ if ($c eq ">");
            $ptr-- if ($c eq "<");
            $array[$ptr]++ if ($c eq "+");
            $array[$ptr]-- if ($c eq "-");
            print(chr($array[$ptr])) if ($c eq ".");
        }
    }
    close(FILE);
}

foreach my $file (@ARGV) {
    exec_bf $file;
}

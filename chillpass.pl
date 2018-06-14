#!/usr/bin/env perl
use strict;
use warnings;
use diagnostics;

use Getopt::Long;

my $length = 5;
my $wordlist = "diceware.wordlist";
my $do_help = 0;

my %words;

sub help {
    print
"usage: $0 [-h] [-l LENGTH] [-w WORDLIST]

optional arguments:
  -h, --help        show this help message and exit
  -l LENGTH, --length LENGTH
                    length of lookup number (default: 5)
  -w WORDLIST, --wordlist WORDLIST
                    path to wordlist (default: diceware.wordlist)
";
    exit(1);
}

sub import_wordlist {
    my @line;
    open(FILE, "<$wordlist") or die "Unable to open wordlist: $wordlist";
    while (<FILE>) {
        @line = split(' ', $_, 2);
        last if @line < 2;
        $words{$line[0]} = $line[1];
    }
}

sub get_word_length {
    my $w = "nope";
    my @keys_arr = keys %words;
    while (!($w =~ /\d/)) {
        $w = $keys_arr[rand @keys_arr];
    }
    return length($w);
}

sub gen_word {
    my @keys_arr = keys %words;
    my $word = "";
    for (1...get_word_length) {
        $word .= 1 + int(rand(6-1));
    }
    die "The wordlist does not contain the key $word\nThere may be a missing number or lines with mixed lengths." if not $words{$word};
    return $words{$word};
}

sub gen_passwd {
    my $length = shift;
    my $passwd = "";
    for (1...$length) {
        $passwd .= gen_word;
    }
    return $passwd;
}

GetOptions(
    "length=i"      => \$length,
    "wordlist=s"    => \$wordlist,
    "help"          => \$do_help,
);

if ($do_help) {
    help;
}

exit if $length == 0;
import_wordlist();
print gen_passwd $length;

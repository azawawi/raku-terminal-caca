#!/usr/bin/env perl6

use v6;
use lib 'lib';
use Terminal::Caca;

# Initialize library
my $o  = Terminal::Caca.new;

# Set window title
$o.title("Window");

# Draw some randomly-colored strings
for 0..31 -> $i {
    # Choose random drawing colours
    $o.color-ansi($o.random-color, $o.random-color);

    # Draw a string
    $o.put-str(10, $i, "Hello world, from Perl 6!");
}

# Refresh display
$o.refresh();

# Wait for a key press
$o.wait-for-keypress();

LEAVE {
    $o.cleanup if $o;
}

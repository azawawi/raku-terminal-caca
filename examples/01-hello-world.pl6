#!/usr/bin/env perl6

use v6;
use lib 'lib';
#TODO remove usage of Terminal::Caca::Raw
use Terminal::Caca::Raw;
use Terminal::Caca;

# Initialise libcaca
my $o  = Terminal::Caca.new;

# Set window title
$o.title("Window");

# Draw some randomly-colored strings
for 0..31 -> $i {
    # Choose random drawing colours
    my $fore-color = (1..CACA_WHITE).pick;
    my $back-color = (1..CACA_WHITE).pick;
    $o.color-ansi($fore-color, $back-color);

    # Draw a string
    $o.put-str(10, $i, "Hello world, from Perl 6!");
}

# Refresh display
$o.refresh();

# Wait for a key press event
$o.wait-for-keypress();

LEAVE {
    $o.cleanup if $o;
}

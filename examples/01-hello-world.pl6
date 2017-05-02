#!/usr/bin/env perl6

use v6;
use lib 'lib';
use Terminal::Caca;

# Initialize library
my $o  = Terminal::Caca.new;

# Set window title
$o.title("Window");

# Draw some randomly-colored strings
constant MAX = 31;
for 0..MAX -> $i {
    # Choose random drawing colours
    $o.color-ansi($o.random-color, $o.random-color);

    # Draw a string
    $o.put-str(10, $i, "Hello world, from Perl 6!");
}

# Draw a totally random line using provided character
$o.color-ansi(Yellow, Black);
$o.line((^MAX).pick, (^MAX).pick, (^MAX).pick, (^MAX).pick, '#');

# Draw a totally thin line using ASCII art
$o.color-ansi(LightMagenta, Black);
$o.thin-line((^MAX).pick, (^MAX).pick, (^MAX).pick, (^MAX).pick);

# Draw a totally random box using provided character
$o.color-ansi(White, Blue);
$o.box((^MAX).pick, (^MAX).pick, (^MAX).pick, (^MAX).pick, '1');

# Draw a totally random thin box using ASCII art
$o.color-ansi(LightGreen, Black);
$o.thin-box((^MAX).pick, (^MAX).pick, (^MAX).pick, (^MAX).pick);

# Refresh display
$o.refresh();

# Wait for a key press
$o.wait-for-keypress();

LEAVE {
    $o.cleanup if $o;
}

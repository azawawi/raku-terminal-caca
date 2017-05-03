#!/usr/bin/env perl6

use v6;
use lib 'lib';
use Terminal::Caca;

# Initialize library
my $o = Terminal::Caca.new;

# Draw a random-positioned line using the given character
given $o {

    # Helper subroutine that returns a random number
    constant MAX = 31;
    my sub random-number { (^MAX).pick }

    # Set the window title
    .title("Perl 6 rocks");

    # Draw some randomly-colored strings
    for 0..MAX -> $i {
        # Draw randomly-colored text
        .color($o.random-color, $o.random-color);
        .text(random-number, $i, "Hello world from Perl 6!");
    }

    .color(yellow, black);
    .line(random-number, random-number, random-number, random-number, 'L');

    # Draw a random-positioned thin line using ASCII art
    .color(light-magenta, black);
    .thin-line(random-number, random-number, random-number, random-number);

    # Draw a random-positioned box using the given character
    .color(white, blue);
    .box(random-number, random-number, random-number, random-number, 'B');

    # Draw a random-positioned thin box using ASCII art
    .color(light-green, black);
    .thin-box(random-number, random-number, random-number, random-number);

    # Draw a random-positioned circle using the given character
    .color(light-red, black);
    .circle(random-number, random-number, random-number, 'C');

    # Draw a random-positioned filled box using the given character
    .color(white, blue);
    .fill-box(random-number, random-number, random-number, random-number, ' ');

    # Refresh display and wait for a key press
    .refresh;
    .wait-for-keypress;
}

LEAVE {
    $o.cleanup if $o;
}

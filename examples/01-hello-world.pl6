#!/usr/bin/env perl6

use v6;
use lib 'lib';
use Terminal::Caca;

# Initialize library and set the window title
my $o = Terminal::Caca.new
        .title("Window");

# Draw some randomly-colored strings
constant MAX = 31;
for 0..MAX -> $i {
    # Draw random colored text
    $o.color($o.random-color, $o.random-color)
      .text(10, $i, "Hello world, from Perl 6!")
}

# Helper subroutine that returns a random number
my sub random-color { (^MAX).pick }

# Draw a random line using the given character
$o  .color(Yellow, Black)
    .line(random-color, random-color, random-color, random-color, 'L')

    # Draw a thin line using ASCII art
    .color(LightMagenta, Black)
    .thin-line(random-color, random-color, random-color, random-color)

    # Draw a random box using the given character
    .color(White, Blue)
    .box(random-color, random-color, random-color, random-color, 'B')

    # Draw a random thin box using ASCII art
    .color(LightGreen, Black)
    .thin-box(random-color, random-color, random-color, random-color)

    # Draw a random circle using the given character
    .color(LightGreen, Black)
    .circle(random-color, random-color, random-color, 'C')

    # Refresh display and wait for a key press
    .refresh
    .wait-for-keypress;

LEAVE {
    $o.cleanup if $o;
}

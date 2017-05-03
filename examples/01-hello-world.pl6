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
    # Draw randomly-colored text
    $o.color($o.random-color, $o.random-color)
      .text(10, $i, "Hello world, from Perl 6!")
}

# Helper subroutine that returns a random number
my sub random-number { (^MAX).pick }

# Draw a random-positioned line using the given character
$o  .color(Yellow, Black)
    .line(random-number, random-number, random-number, random-number, 'L')
    #
    # Draw a random-positioned thin line using ASCII art
    #
    .color(LightMagenta, Black)
    .thin-line(random-number, random-number, random-number, random-number)
    #
    # Draw a random-positioned box using the given character
    #
    .color(White, Blue)
    .box(random-number, random-number, random-number, random-number, 'B')
    #
    # Draw a random-positioned thin box using ASCII art
    #
    .color(LightGreen, Black)
    .thin-box(random-number, random-number, random-number, random-number)
    #
    # Draw a random-positioned circle using the given character
    #
    .color(LightRed, Black)
    .circle(random-number, random-number, random-number, 'C')
    #
    # Refresh display and wait for a key press
    #
    .refresh
    .wait-for-keypress;

LEAVE {
    $o.cleanup if $o;
}

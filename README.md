# Terminal::Caca [![Build Status](https://travis-ci.org/azawawi/perl6-terminal-caca.svg?branch=master)](https://travis-ci.org/azawawi/perl6-terminal-caca)

Terminal::Caca - Use libcaca (Colour AsCii Art library) API in Perl 6

The library is currently **experimental**. The plan is to provide ``::NativeCall``
and OO-style Perl6ish kebab-case API.

## Example

```Perl6
use v6;
use Terminal::Caca::Raw;

# Initialise libcaca
my $dp = caca_create_display(CacaDisplay.new);
my $cv = caca_get_canvas($dp);

# Set window title
caca_set_display_title($dp, "Window");

# Choose drawing colours
caca_set_color_ansi($cv, CACA_BLACK, CACA_WHITE);

# Draw some strings
for 0..31 -> $i {
    caca_put_str($cv, 10, $i, "Hello world, from Perl 6!");
    my $fore-color = (1..CACA_WHITE).pick;
    my $back-color = (1..CACA_WHITE).pick;
    caca_set_color_ansi($cv, $fore-color, $back-color);
}

# Refresh display
caca_refresh_display($dp);

# Wait for a key press event
caca_get_event($dp, CACA_EVENT_KEY_PRESS, NULL, -1);

# Clean up library
caca_free_display($dp);
```

For more examples, please see the [examples](examples) folder.

## Installation

* On Debian-based linux distributions, please use the following command:
```
$ sudo apt-get install libcaca-dev
```

* On Mac OS X, please use the following command:
```
$ brew update
$ brew install libcaca
```

* Using zef (a module management tool bundled with Rakudo Star):
```
$ zef install Terminal::Caca
```

## Testing

- To run tests:
```
$ prove -ve "perl6 -Ilib"
```

- To run all tests including author tests (Please make sure
[Test::Meta](https://github.com/jonathanstowe/Test-META) is installed):
```
$ zef install Test::META
$ AUTHOR_TESTING=1 prove -e "perl6 -Ilib"
```

## Author

Ahmad M. Zawawi, azawawi on #perl6, https://github.com/azawawi/

## License

WTFPL

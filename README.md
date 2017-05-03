# Terminal::Caca [![Build Status](https://travis-ci.org/azawawi/perl6-terminal-caca.svg?branch=master)](https://travis-ci.org/azawawi/perl6-terminal-caca)

Terminal::Caca - Use libcaca (Colour AsCii Art library) API in Perl 6

**NOTE:** The library is currently **experimental**. You have been warned :)

Normally you would use the safer object-oriented API via `Terminal::Caca`. If
you need to access raw API for any reason, please use `Terminal::Caca::Raw`.

## Example

```Perl6
use v6;
use Terminal::Caca;

# Initialize library and set window title
my $obj = Terminal::Caca.new
    .title("Window");

# Draw some randomly-colored strings
for 0..31 -> $i {
    # Draw random colored text
    $obj.color($obj.random-color, $obj.random-color)
        .text(10, $i, "Hello world, from Perl 6!")
}

# Refresh display & Wait for a key press event
$obj.refresh
    .wait-for-keypress;

LEAVE {
    $obj.cleanup if $obj;
}
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

MIT

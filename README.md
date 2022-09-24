# Terminal::Caca
[![Actions
Status](https://github.com/azawawi/raku-terminal-caca/workflows/test/badge.svg)](https://github.com/azawawi/raku-terminal-caca/actions)

Terminal::Caca - Use libcaca (Colour AsCii Art library) API in Raku 

**NOTE:** The library is currently **experimental**. You have been warned :)

Normally you would use the safer object-oriented API via `Terminal::Caca`. If
you need to access raw API for any reason, please use `Terminal::Caca::Raw`.

## Example

```Raku
use v6;
use Terminal::Caca;

# Initialize library
given my $o = Terminal::Caca.new {
    # Set window title
    .title("Raku rocks");

    # Say hello world
    my $text = ' Hello world, from Raku! ';
    .color(white, blue);
    .text(10, 10, $text);

    # Draw an ASCII-art box around it
    .thin-box(9, 9, $text.chars + 2, 3);

    # Refresh display
    .refresh;

    # Wait for a key press event
    .wait-for-keypress;

    # Cleanup on scope exit
    LEAVE {
        .cleanup;
    }
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
$ prove --ext .rakutest -ve "raku -I."
```

- To run all tests including author tests (Please make sure
[Test::Meta](https://github.com/jonathanstowe/Test-META) is installed):
```
$ zef install Test::META
$ AUTHOR_TESTING=1 prove --ext .rakutest -ve "raku -I."
```

## Author

Ahmad M. Zawawi, azawawi on #raku, https://github.com/azawawi/

## License

MIT

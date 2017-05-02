
use v6;

# Cooked API :)
unit class Terminal::Caca;

use Terminal::Caca::Raw;

# Fields
has CacaDisplay $!dp;
has CacaCanvas $!cv;

enum CacaColor (
    Black        => CACA_BLACK,
    Blue         => CACA_BLUE,
    Green        => CACA_GREEN,
    Cyan         => CACA_CYAN,
    Red          => CACA_RED,
    Magenta      => CACA_MAGENTA,
    Brown        => CACA_BROWN,
    LightGray    => CACA_LIGHTGRAY,
    DarkGray     => CACA_DARKGRAY,
    LightBlue    => CACA_LIGHTBLUE,
    LightGreen   => CACA_LIGHTGREEN,
    LightCyan    => CACA_LIGHTCYAN,
    LightRed     => CACA_LIGHTRED,
    LightMagenta => CACA_LIGHTMAGENTA,
    Yellow       => CACA_YELLOW,
    White        => CACA_WHITE,
    Default      => CACA_DEFAULT,
    Transparent  => CACA_TRANSPARENT,
);

submethod BUILD {
    my $NULL = CacaDisplay.new;
    $!dp     = caca_create_display($NULL);
    die "Could create display handle" unless $!dp;
    $!cv     = caca_get_canvas($!dp);
    die "Could create canvas handle"  unless $!cv;
}

method cleanup {
    die "Display handle not initialized" unless $!dp;
    my $ret = caca_free_display($!dp);
    die "Invalid return result" unless $ret == 0;
}

submethod version returns Str {
    return caca_get_version;
}

method refresh {
    die "Display handle not initialized" unless $!dp;
    my $ret = caca_refresh_display($!dp);
    die "Invalid return result" unless $ret == 0;
}

method title($title) {
    die "Display handle not initialized" unless $!dp;
    my $ret = caca_set_display_title($!dp, $title);
    die "Invalid return result" unless $ret == 0;
}

method color-ansi($fore-color = White, $back-color = Black) {
    die "Canvas handle not initialized" unless $!cv;
    my $ret = caca_set_color_ansi($!cv, $fore-color, $back-color);
    die "Invalid return result" unless $ret == 0;
}

method put-str(Int $x, Int $y, Str $string) returns Int {
    die "Canvas handle not initialized" unless $!cv;
    caca_put_str($!cv, $x, $y, $string);
}

method wait-for-keypress {
    die "Display handle not initialized" unless $!dp;
    my $ret = caca_get_event($!dp, CACA_EVENT_KEY_PRESS, 0, -1);
    die "Invalid return result" unless $ret == 0;
}

method random-color {
    return (Black..White).pick;
}

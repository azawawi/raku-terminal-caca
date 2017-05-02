
use v6;

# Cooked API :)
unit class Terminal::Caca;

use Terminal::Caca::Raw;

# Fields
has CacaDisplay $!dp;
has CacaCanvas $!cv;

submethod BUILD {
    my $NULL = CacaDisplay.new;
    $!dp     = caca_create_display($NULL);
    $!cv     = caca_get_canvas($!dp);
    #TODO check return result
}

method cleanup {
    caca_free_display($!dp);
    #TODO check return result
}

method refresh {
    caca_refresh_display($!dp);
    #TODO check return result
}

method title($title) {
    die "Display handle not initialized" unless $!dp;
    caca_set_display_title($!dp, $title);
    #TODO check return result
}

method color-ansi(Int $fore-color = CACA_WHITE, Int $back-color = CACA_BLACK) {
    die "Canvas handle not initialized" unless $!cv;
    caca_set_color_ansi($!cv, $fore-color, $back-color);
    #TODO check return result
}

method put-str(Int $x, Int $y, Str $string) {
    die "Canvas handle not initialized" unless $!cv;
    caca_put_str($!cv, $x, $y, $string);
    #TODO check return result
}

method wait-for-keypress {
    die "Display handle not initialized" unless $!dp;
    caca_get_event($!dp, CACA_EVENT_KEY_PRESS, 0, -1);
    #TODO check return result
}

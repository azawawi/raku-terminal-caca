
use v6;

# Cooked API :)
unit class Terminal::Caca;

use Terminal::Caca::Raw;

# Fields
has CacaDisplay $!dp;
has CacaCanvas $!cv;

# Color Enumeration
enum CacaColor is export (
    black         => CACA_BLACK,
    blue          => CACA_BLUE,
    green         => CACA_GREEN,
    cyan          => CACA_CYAN,
    red           => CACA_RED,
    magenta       => CACA_MAGENTA,
    brown         => CACA_BROWN,
    light-gray    => CACA_LIGHTGRAY,
    dark-gray     => CACA_DARKGRAY,
    light-blue    => CACA_LIGHTBLUE,
    light-green   => CACA_LIGHTGREEN,
    light-cyan    => CACA_LIGHTCYAN,
    light-red     => CACA_LIGHTRED,
    light-magenta => CACA_LIGHTMAGENTA,
    yellow        => CACA_YELLOW,
    white         => CACA_WHITE,
    color-default => CACA_DEFAULT,
    transparent   => CACA_TRANSPARENT,
);

enum CacaEvent is export (
     event-none    => CACA_EVENT_NONE,          #  No event.
     key-press     => CACA_EVENT_KEY_PRESS,     #  A key was pressed.
     key-release   => CACA_EVENT_KEY_RELEASE,   #  A key was released.
     mouse-press   => CACA_EVENT_MOUSE_PRESS,   #  A mouse button was pressed.
     mouse-release => CACA_EVENT_MOUSE_RELEASE, #  A mouse button was released.
     mouse-motion  => CACA_EVENT_MOUSE_MOTION,  #  The mouse was moved.
     resize        => CACA_EVENT_RESIZE,        #  The window was resized.
     quit          => CACA_EVENT_QUIT,          #  The user requested to quit.
     event-any     => CACA_EVENT_ANY,           #  Any event.
);

#
# Error checking utility methods
#
method _check_display_handle {
    die "Display handle not initialized" unless $!dp;
}

method _check_canvas_handle {
    die "Canvas handle not initialized" unless $!cv;
}

method _check_return_result($ret) {
    die "Invalid return result" unless $ret == 0;
}

method _ensure_one_char(Str $char) {
    warn "A single character is expected" unless $char.chars == 1;
}

# Constructor
submethod BUILD {
    my $NULL = CacaDisplay.new;
    $!dp     = caca_create_display($NULL);
    self._check_display_handle;
    $!cv     = caca_get_canvas($!dp);
    self._check_canvas_handle;
}

# This should be called on scope exit to perform cleanup
method cleanup {
    self._check_display_handle;
    my $ret = caca_free_display($!dp);
    warn "Invalid return result" if $ret != 0;
}

submethod version returns Str {
    caca_get_version
}

method refresh {
    self._check_display_handle;
    my $ret = caca_refresh_display($!dp);
    self._check_return_result($ret);
}

method title(Str $title) {
    self._check_display_handle;
    my $ret = caca_set_display_title($!dp, $title);
    self._check_return_result($ret);
}

method color(
    CacaColor $fore-color = white,
    CacaColor $back-color = black)
{
    self._check_canvas_handle;
    my $ret = caca_set_color_ansi($!cv, $fore-color, $back-color);
    self._check_return_result($ret);
}

method text(Int $x, Int $y, Str $string) returns Int {
    self._check_canvas_handle;
    return caca_put_str($!cv, $x, $y, $string);
}

method line(Int $x1, Int $y1, Int $x2, Int $y2, Str $char = '#') {
    self._check_canvas_handle;
    self._ensure_one_char($char);
    my $ret = caca_draw_line($!cv, $x1, $y1, $x2, $y2, $char.ord);
    self._check_return_result($ret);
}

method thin-line(Int $x1, Int $y1, Int $x2, Int $y2) {
    self._check_canvas_handle;
    my $ret = caca_draw_thin_line($!cv, $x1, $y1, $x2, $y2);
    self._check_return_result($ret);
}

method box(Int $x1, Int $y1, Int $x2, Int $y2, Str $char = '#') {
    self._check_canvas_handle;
    self._ensure_one_char($char);
    my $ret = caca_draw_box($!cv, $x1, $y1, $x2, $y2, $char.ord);
    self._check_return_result($ret);
}

method thin-box(Int $x1, Int $y1, Int $x2, Int $y2) {
    self._check_canvas_handle;
    my $ret = caca_draw_thin_box($!cv, $x1, $y1, $x2, $y2);
    self._check_return_result($ret);
}

method circle(Int $x, Int $y, Int $radius, Str $char = '#') {
    self._check_canvas_handle;
    self._ensure_one_char($char);
    my $ret = caca_draw_circle($!cv, $x, $y, $radius, $char.ord);
    self._check_return_result($ret);
}

method clear {
    self._check_canvas_handle;
    my $ret = caca_clear_canvas($!cv);
    self._check_return_result($ret);
}

method wait-for-keypress {
    self._check_display_handle;
    my $ret = caca_get_event($!dp, CACA_EVENT_KEY_PRESS, 0, -1);
    #TODO how to handle timeout and match return type
}

method wait-for-event(CacaEvent $event = CacaEvent.key-press) returns Int {
    self._check_display_handle;
    #TODO pass timeout and handle return type
    caca_get_event($!dp, $event, 0, -1);
}

method random-color returns CacaColor {
    return CacaColor((black..white).pick);
}

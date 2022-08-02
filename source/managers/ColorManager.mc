import Toybox.Graphics;

class ColorManager {
    (:multipleColorVersion)
    static function get(color) {
        return color == Graphics.COLOR_BLACK ? color : Graphics.COLOR_WHITE;
    }

    (:singleColorVersion)
    static function get(color) {
        return color;
    }
}

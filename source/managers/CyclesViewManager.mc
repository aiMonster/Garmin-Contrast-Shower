import Toybox.Graphics;

class CyclesViewManager {
    private static var HOT_TITLE = "HOT";
    private static var COLD_TITLE = "COLD";
    private static var SWITCH_TITLE = "SWITCH";

    private static var HOT_COLOR = Graphics.COLOR_DK_RED;
    private static var COLD_COLOR = Graphics.COLOR_BLUE;
    private static var SWITCH_COLOR = Graphics.COLOR_ORANGE;

    static function getTypeLabel(waterType as WaterType) as String {
        switch(waterType) {
            case WaterType.Hot:
                return HOT_TITLE;
            case WaterType.Cold:
                return COLD_TITLE;
            case WaterType.Switch:
                return SWITCH_TITLE;
        }
    }

    static function getTypeColor(waterType as WaterType) {
        switch(waterType) {
            case WaterType.Hot:
                return ColorManager.get(HOT_COLOR);
            case WaterType.Cold:
                return ColorManager.get(COLD_COLOR);
            case WaterType.Switch:
                return ColorManager.get(SWITCH_COLOR);
        }
    }

    static function formatTime(minutes as Number, seconds as Number) as String {
        var secondsFormatted = seconds > 9 ? seconds.toString() : "0" + seconds.toString();
        return minutes.toString() + ":" + secondsFormatted;
    }

    static function formatCycles(cycles as Number) as String {
        var multipleSign = cycles == 1 ? "" : "s";
        return cycles.toString() + " cycle" + multipleSign + " left";
    }
}
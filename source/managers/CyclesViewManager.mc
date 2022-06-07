import Toybox.Graphics;

class CyclesViewManager {
    private static var HOT_TITLE = "HOT";
    private static var COLD_TITLE = "COLD";
    private static var HOT_COLOR = Graphics.COLOR_DK_RED;
    private static var COLD_COLOR = Graphics.COLOR_BLUE;

    static function getTypeLabel(waterType as WaterType) as String {
        return waterType == WaterType.Hot ? HOT_TITLE : COLD_TITLE;
    }

    static function getTypeColor(waterType as WaterType) {
        var color = waterType == WaterType.Hot ? HOT_COLOR : COLD_COLOR;
        return ColorManager.get(color);
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
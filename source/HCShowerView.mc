import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.System;

class HCShowerView extends WatchUi.View {
    private var COLD_TITLE = "COLD";
    private var COLD_COLOR = Graphics.COLOR_BLUE;

    private var HOT_TITLE = "HOT";
    private var HOT_COLOR = Graphics.COLOR_DK_RED;

    private var _typeTitleElement;
    private var _currentTimerElement;
    private var _cylclesLeftElement;

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));

        _typeTitleElement = findDrawableById("type_title");
        _currentTimerElement = findDrawableById("current_timer");
        _cylclesLeftElement = findDrawableById("cylcles_left");
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        // TODO: Should be taken from some configs
        setWaterTypeValue(WaterType.Hot);
        setCyclesValue(6);
        setTimerValue(30);
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    function setCyclesValue(value as Number) as Void {
        var multipleSign = value == 1 ? "" : "s";
        var formattedValue = value.toString() + " cycle" + multipleSign + " left";
        _cylclesLeftElement.setText(formattedValue);

        WatchUi.requestUpdate();
    }

    function setWaterTypeValue(waterType as WaterType) as Void {
        if (waterType == WaterType.Hot) {
            _typeTitleElement.setText(HOT_TITLE);
            _typeTitleElement.setColor(HOT_COLOR);
        } else if (waterType == WaterType.Cold) {
            _typeTitleElement.setText(COLD_TITLE);
            _typeTitleElement.setColor(COLD_COLOR);
        }

        WatchUi.requestUpdate();
    }

    function setTimerValue(value as Number) as Void {
        var current = formatTime(value/60, value%60);

        _currentTimerElement.setText(current);

        WatchUi.requestUpdate();
    }

    private function formatTime(minutes as Number, seconds as Number) as String {
        var secondsFormatted = seconds > 9 ? seconds.toString() : "0" + seconds.toString();
        return minutes.toString() + ":" + secondsFormatted;
    }
}

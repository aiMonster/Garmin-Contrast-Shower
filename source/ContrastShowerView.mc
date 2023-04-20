import Toybox.WatchUi;
import Toybox.Graphics;

class ContrastShowerView extends WatchUi.View {
    private var _typeTitleElement;
    private var _currentTimerElement;
    private var _cylclesLeftElement;

    // Constructor
    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));

        _typeTitleElement = findDrawableById("type_title");
        _currentTimerElement = findDrawableById("current_timer");
        _cylclesLeftElement = findDrawableById("cylcles_left");

        _typeTitleElement.setColor(ColorManager.get(Graphics.COLOR_BLUE));
        _currentTimerElement.setColor(ColorManager.get(Graphics.COLOR_WHITE));
        _cylclesLeftElement.setColor(ColorManager.get(Graphics.COLOR_WHITE));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        var firstCycle = CyclesManager.getCycleByIndex(0);

        setTimerValue(firstCycle.duration);
        setWaterTypeValue(firstCycle.waterType);
        setCyclesValue(CyclesManager.getCyclesCount());
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

    // Updates cycles value on the view
    function setCyclesValue(cycles) as Void {
        var formattedValue = CyclesViewManager.formatCycles(cycles);
        _cylclesLeftElement.setText(formattedValue);

        WatchUi.requestUpdate();
    }

    // Updates water type value on the view
    function setWaterTypeValue(waterType as WaterType) as Void {
        var label = CyclesViewManager.getTypeLabel(waterType);
        var color = CyclesViewManager.getTypeColor(waterType);

        _typeTitleElement.setText(label);
        _typeTitleElement.setColor(color);

        WatchUi.requestUpdate();
    }

    // Updates timer value on the view
    function setTimerValue(value) as Void {
        var current = CyclesViewManager.formatTime(value/60, value%60);
        _currentTimerElement.setText(current);

        WatchUi.requestUpdate();
    }
}

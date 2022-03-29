import Toybox.WatchUi;

class MainMenuViewDelegate extends WatchUi.Menu2InputDelegate {
    private var _mainMenuView;

    // Constructor
    function initialize() {
        _mainMenuView = new MainMenu();
        Menu2InputDelegate.initialize();
    }

    // On Select button clicked
    function onSelect(item as MenuItem) as Void {
        var id = item.getId().toString();

        var label = null, color = null, initialValue = null, callback = null;
        var showSeconds = false;

        if (id.equals("hot_duration")) {
            label = CyclesViewManager.getTypeLabel(WaterType.Hot);
            color = CyclesViewManager.getTypeColor(WaterType.Hot);
            initialValue = CyclesManager.getCycleDuration(WaterType.Hot);
            showSeconds = true;
            callback = method(:updateHotWaterSettings); 
        } else if(id.equals("cold_duration")) {
            label = CyclesViewManager.getTypeLabel(WaterType.Cold);
            color = CyclesViewManager.getTypeColor(WaterType.Cold);
            initialValue = CyclesManager.getCycleDuration(WaterType.Cold);
            showSeconds = true;
            callback = method(:updateColdWaterSettings); 
        } else if (id.equals("cycles_count")) {
            label = "CYCLES";
            color = Graphics.COLOR_WHITE;
            initialValue = CyclesManager.getCyclesCount();
            showSeconds = false;
            callback = method(:updateCyclesSettings); 
        }

        var picker = new NumberPicker(label, color, showSeconds, initialValue);
        var delegate = new NumberPickerDelegate(callback);

        WatchUi.pushView(picker, delegate, WatchUi.SLIDE_IMMEDIATE);
    }

    function updateHotWaterSettings(value as Number) as Void {
        _mainMenuView.updateSublabel("hot_duration", value);
        CyclesManager.setCycleDuration(WaterType.Hot, value);
    }

    function updateColdWaterSettings(value as Number) as Void {
        _mainMenuView.updateSublabel("cold_duration", value);
        CyclesManager.setCycleDuration(WaterType.Cold, value);
    }

    function updateCyclesSettings(value as Number) as Void {
        _mainMenuView.updateSublabel("cycles_count", value);
        CyclesManager.setCyclesCount(value);
    }
}
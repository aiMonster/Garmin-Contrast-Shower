import Toybox.System;
import Toybox.WatchUi;

class MainMenu {
    private static var _menu;

    function initialize() {
        if(_menu == null) {
            setMenu();
        }
    }

    function getView() {
        return _menu;
    }

    function updateSublabel(id, value) {
        switch(id) {
            case "hot_duration":
                _menu.getItem(0).setSubLabel(value.toString() + "sec");
                break;
            case "cold_duration":
                _menu.getItem(1).setSubLabel(value.toString() + "sec");
                break;
            case "switch_duration":
                _menu.getItem(2).setSubLabel(value.toString() + "sec");
                break;
            case "cycles_count":
                _menu.getItem(3).setSubLabel(value.toString());
                break;
        }
    }

    private function setMenu() {
        _menu = new WatchUi.Menu2(null);

        var hotDurationLbl = CyclesManager.getCycleDuration(WaterType.Hot).toString() + "sec";
        var coldDurationLbl = CyclesManager.getCycleDuration(WaterType.Cold).toString() + "sec";
        var swtichDurationLbl = CyclesManager.getCycleDuration(WaterType.Switch).toString() + "sec";
        var cyclesCountLbl = CyclesManager.getCyclesCount().toString();
   
        _menu.addItem(new WatchUi.MenuItem("Hot duration", hotDurationLbl, "hot_duration", null));
        _menu.addItem(new WatchUi.MenuItem("Cold duration", coldDurationLbl, "cold_duration", null));
        _menu.addItem(new WatchUi.MenuItem("Switch duration", swtichDurationLbl, "switch_duration", null));
        _menu.addItem(new WatchUi.MenuItem("Cycles", cyclesCountLbl, "cycles_count", null));
        _menu.addItem(new WatchUi.ToggleMenuItem(
            "Record activity", 
            {:enabled=>"Yes", :disabled=>"No"},
            "record_activity",
            ActivityManager.getRecordActivityFlag(),
            null
        ));
        _menu.addItem(new WatchUi.ToggleMenuItem(
            "Double click", 
            {:enabled=>"Yes", :disabled=>"No"},
            "use_double_click",
            CyclesManager.getUseDoubleClickFlag(),
            null
        ));
    }
}
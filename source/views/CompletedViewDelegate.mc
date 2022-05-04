import Toybox.WatchUi;

class CompletedViewDelegate extends WatchUi.BehaviorDelegate {
    // Constructor
    function initialize() {
        BehaviorDelegate.initialize();
    }

    // On Select button click
    function onSelect() as Boolean {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        
        return true;
    }
}
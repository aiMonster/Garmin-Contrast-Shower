import Toybox.WatchUi;

class CompletedPlainViewDelegate extends WatchUi.BehaviorDelegate {
    // Constructor
    function initialize(view as CompletedPlainView) {
        BehaviorDelegate.initialize();
    }

    // On Select button click
    function onSelect() {    
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        
        return true;
    }
}
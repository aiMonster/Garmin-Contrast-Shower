import Toybox.Application;

class ActivityManager {
    static function getRecordActivityFlag() {
        return Application.Properties.getValue("recordActivity");
    }

    static function setRecordActivityFlag(enabled as Boolean) {
        return Application.Properties.setValue("recordActivity", enabled);
    }
}
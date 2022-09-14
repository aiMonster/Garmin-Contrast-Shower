import Toybox.Application;
import Toybox.ActivityRecording;

class ActivityManager {
    private static var _session as Session?;

    // Get Record Activity flag value
    static function getRecordActivityFlag() {
        return Application.Properties.getValue("recordActivity");
    }

    // Set Record Activity flag value
    static function setRecordActivityFlag(enabled as Boolean) {
        return Application.Properties.setValue("recordActivity", enabled);
    }

    // Create and start new seesion
    static function startSession() as Void {
        _session = ActivityRecording.createSession({:name=>"Contrast Shower", :sport=>ActivityRecording.SPORT_GENERIC});
        _session.start();
    }

    // Add new lap
    static function addLap() as Void {
        if(_session) {
            _session.addLap();
        }
    }

    // Stop session
    static function stopSession() as Void {
        if(_session) {
            _session.stop();
        }
    }

    // Save session
    static function saveSession() as Void {
        if(_session) {
            _session.save();
            _session = null;
        }
    }

    // Discard session
    static function discardSession() as Void {
        if(_session) {
            _session.discard();
            _session = null;
        }
    }
}
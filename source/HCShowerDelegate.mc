import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Attention;
import Toybox.Timer;

class HCShowerDelegate extends WatchUi.BehaviorDelegate {
    private var _view = getView();
    private var _timer;

    private var _inProgress = false;

    private var _currentDuration;

    private var _currentCycle;
    private var _cyclesCount;

    // Constructor
    function initialize() {
        BehaviorDelegate.initialize();
    }

    // On Select button click
    function onSelect() as Boolean {
        if (_inProgress == false) {
            _inProgress = true;
            startCountdown();
        }
        
        return true;
    }

    // Starts countdown
    function startCountdown() {
        _currentCycle = 0;
        _cyclesCount = CyclesManager.getCyclesCount();

        _currentDuration = CyclesManager.getCycleByIndex(0).duration - 1;
        _view.setCyclesValue(_cyclesCount - 1);
        
        callAttention();

        _timer = new Timer.Timer();
        _timer.start(method(:updateCountdownValue), 1000, true);
    }

    function updateCountdownValue() {
        var isLastCycle = _currentCycle == _cyclesCount - 1;

        // If its the last tick
        if (isLastCycle && _currentDuration == 0) {
            callAttention();
            _view.setTimerValue(0);

            _timer.stop();
            _inProgress = false;

            // TODO: Show completed icon
            return;
        }

        // If its the last tick in the cycle
        if (_currentDuration == 0) {
            callAttention();
            _currentCycle++;

            var cycle = CyclesManager.getCycleByIndex(_currentCycle);

            _view.setCyclesValue(_cyclesCount - _currentCycle - 1);
            _view.setWaterTypeValue(cycle.waterType);

            _currentDuration = cycle.duration;
        }

        _view.setTimerValue(_currentDuration);
        _currentDuration--;
    }

    // Calls an attention by vibration and backlight
    function callAttention() as Void {
        var vibeData = [new Attention.VibeProfile(100, 2000)];
        Attention.vibrate(vibeData);
        Attention.backlight(true);

        new Timer.Timer().start(method(:turnOffBacklight), 3000, false);
    }

    // Turns off backlight
    function turnOffBacklight() as Void {
        Attention.backlight(false);
    }
}
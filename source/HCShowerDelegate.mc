import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Attention;
import Toybox.Timer;

class HCShowerDelegate extends WatchUi.BehaviorDelegate {
    private var _view = getView();
    private var _timer;

    private var cycles = [
        new WaterCycle(WaterType.Hot, 30),
        new WaterCycle(WaterType.Cold, 30),
        new WaterCycle(WaterType.Hot, 30),
        new WaterCycle(WaterType.Cold, 30),
        new WaterCycle(WaterType.Hot, 30),
        new WaterCycle(WaterType.Cold, 30)
    ];

    private var _totalDuration;
    private var _currentDuration;
    private var _currentCycle;

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onSelect() as Boolean {
        startCountdown();
        return true;
    }

    private function startCountdown() {
        _totalDuration = 0;
        for (var i = 0; i < cycles.size(); i++) {
            _totalDuration += cycles[i].duration;
        }

        _currentCycle = 0;
        _currentDuration = cycles[0].duration - 1;
        _totalDuration--;
        _view.setCyclesValue(cycles.size() - 1);
        
        callAttention();
        _timer = new Timer.Timer();
        _timer.start(method(:updateCountdownValue), 1000, true);
    }

    function updateCountdownValue() {
        if (_totalDuration == 0) {
            callAttention();
            _view.setTimerValue(0);
            _timer.stop();
            return;
            // TODO: Show completed icon
        }

        if (_currentDuration == 0) {
            callAttention();
            _view.setCyclesValue(cycles.size() - _currentCycle - 2);

            _currentCycle++;
            _view.setWaterTypeValue(cycles[_currentCycle].waterType);
            _currentDuration = cycles[_currentCycle].duration;
        }

        _view.setTimerValue(_currentDuration);

        _totalDuration--;
        _currentDuration--;
    }

    function callAttention() as Void {
        var vibeData = [new Attention.VibeProfile(100, 2000)];
        Attention.vibrate(vibeData);
        Attention.backlight(true);

        new Timer.Timer().start(method(:turnOffBacklight), 3000, false);
    }

    function turnOffBacklight() as Void {
        Attention.backlight(false);
    }
}
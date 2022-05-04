import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Attention;
import Toybox.Timer;
import Toybox.ActivityRecording;

class ContrastShowerDelegate extends WatchUi.BehaviorDelegate {
    private var _view = getView();
    private var _session as Session?;
    private var _timer;

    private var _inProgress = false;

    private var _currentDuration;

    private var _currentCycle;
    private var _cyclesCount;

    // Constructor
    function initialize() {
        BehaviorDelegate.initialize();
    }

    // On Menu click
    function onMenu() as Boolean {
        WatchUi.pushView(new MainMenu().getView(), new MainMenuViewDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

    // On Select button click
    function onSelect() as Boolean {
        if (_inProgress == false) {
            _inProgress = true;

            if (ActivityManager.getRecordActivityFlag()) {
                _session = ActivityRecording.createSession({:name=>"Contrast Shower", :sport=>ActivityRecording.SPORT_GENERIC});
                _session.start();
            }
            
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

            if(_session) {
                _session.stop();
                _session.save();
                _session = null;
            }

            _inProgress = false;

            WatchUi.switchToView(new CompletedView(), new CompletedViewDelegate(), WatchUi.SLIDE_UP);

            return;
        }

        // If its the last tick in the cycle
        if (_currentDuration == 0) {
            callAttention();
            _currentCycle++;

            if(_session) {
                _session.addLap();
            }
            
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
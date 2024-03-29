import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Attention;
import Toybox.Timer;

class ContrastShowerDelegate extends WatchUi.BehaviorDelegate {
    private static var LONG_DURATION = 1500;
    private static var MIDDLE_DURATION = 700;
    private static var SHORT_DURATION = 250;
    private static var MAX_CLICK_INTERVAL_SEC = 1;

    private var _view = getView();
    private var _timer;

    private var _inProgress = false;

    private var _currentDuration;

    private var _currentCycle;
    private var _cyclesCount;

    private var _lastSelectBtnClick = null;
    private var _lastBackBtnClick = null;

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
        var doubleClick = _lastBackBtnClick != null && Time.now().subtract(_lastBackBtnClick).value() <= MAX_CLICK_INTERVAL_SEC;

        if (CyclesManager.getUseDoubleClickFlag() && !doubleClick) {
            _lastBackBtnClick = Time.now();
            return true;
        }

        if (_inProgress == false) {
            _inProgress = true;

            if (ActivityManager.getRecordActivityFlag()) {
                ActivityManager.startSession();
            }
            
            startCountdown();
        }
        
        return true;
    }


    // On Back button click
    function onBack() as Boolean {
        var doubleClick = _lastBackBtnClick != null && Time.now().subtract(_lastBackBtnClick).value() <= MAX_CLICK_INTERVAL_SEC;

        if (CyclesManager.getUseDoubleClickFlag() && !doubleClick) {
            _lastBackBtnClick = Time.now();
            return true;
        }

        ActivityManager.discardSession();

        return false;
    }

    // Starts countdown
    function startCountdown() {
        _currentCycle = 0;

        _cyclesCount = (CyclesManager.getCyclesCount() * 2) - 1;

        _currentDuration = CyclesManager.getCycleByIndex(_currentCycle).duration - 1;
        updateCyclesValue();

        callAttention(LONG_DURATION, true);

        _timer = new Timer.Timer();
        _timer.start(method(:updateCountdownValue), 1000, true);
    }

    function updateCountdownValue() {
        var isLastCycle = _currentCycle == _cyclesCount - 1;

        // If its the last tick
        if (isLastCycle && _currentDuration == 0) {
            callAttention(LONG_DURATION, true);
            _view.setTimerValue(0);

            _timer.stop();

            ActivityManager.stopSession();

            _inProgress = false;

            if (ActivityManager.getRecordActivityFlag()) {
                var completedView = new CompletedView();
                WatchUi.switchToView(completedView, new CompletedViewDelegate(completedView), WatchUi.SLIDE_UP);
            } else {
                var completedView = new CompletedPlainView();
                WatchUi.switchToView(completedView, new CompletedPlainViewDelegate(completedView), WatchUi.SLIDE_UP);
            }
            
            return;
        }

        // If its the last tick in the cycle
        if (_currentDuration == 0) {
            _currentCycle++;

            ActivityManager.addLap();

            var cycle = CyclesManager.getCycleByIndex(_currentCycle);
            var afterSwitch = cycle.waterType != WaterType.Switch;

            updateCyclesValue();

            callAttention(afterSwitch ? SHORT_DURATION : MIDDLE_DURATION, !afterSwitch);

            _view.setWaterTypeValue(cycle.waterType);

            _currentDuration = cycle.duration;
        }

        _view.setTimerValue(_currentDuration);
        _currentDuration--;
    }

    function updateCyclesValue() as Void {
        _view.setCyclesValue((_cyclesCount - _currentCycle - 1) / 2);
    }

    // Calls an attention by vibration and backlight
    function callAttention(duration as Number, backlight as Boolean) as Void {
        var vibeData = [new Attention.VibeProfile(100, duration)];
        Attention.vibrate(vibeData);
        Attention.backlight(backlight);

        new Timer.Timer().start(method(:turnOffBacklight), 3000, false);
    }

    // Turns off backlight
    function turnOffBacklight() as Void {
        Attention.backlight(false);
    }
}
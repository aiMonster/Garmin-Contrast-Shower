import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Attention;
import Toybox.Timer;
import Toybox.Time;

class NotificationManager {
  private var VIBE_DURATION as Dictionary<AttentionLevel, Number> =
    ({
      AttentionLevel.Low => 250,
      AttentionLevel.Medium => 700,
      AttentionLevel.High => 1500,
    }) as Dictionary<AttentionLevel, Number>;

  private var _timer = new Timer.Timer();

  private var _callbacks = [];
  private var _turnOffBacklightAt = null;

  /* Constructor **/
  function initialize() {
    _timer = new Timer.Timer();
    _timer.start(method(:triggerCallbacks), 1000, true);
  }

  /* Subscribe a callback to be called every second **/
  function callEverySecond(callbackFn) as Void {
    _callbacks.add(callbackFn);

    return _callbacks.size() - 1;
  }

  /* Unsubscribe a callback by specified index **/
  function removeCallback(index) as Void {
    _callbacks[index] = null;
  }

  /* Calls all existing timer callbacks **/
  function triggerCallbacks() as Void {
    for (var i = _callbacks.size() - 1; i >= 0; i -= 1) {
      if (_callbacks[i] != null) {
        _callbacks[i].invoke();
      }
    }

    if (_turnOffBacklightAt != null && _turnOffBacklightAt < System.getTimer()) {
      turnOffBacklight();
    }
  }

  /* Calls an attention by vibration and backlight **/
  function callAttention(level, backlight) as Void {
    if (Attention has :vibrate) {
      var vibeData = [new Attention.VibeProfile(100, VIBE_DURATION[level])];
      Attention.vibrate(vibeData);
    }

    if (backlight) {
      tryToggleBacklight(true);

      _turnOffBacklightAt = System.getTimer() + 3000;
    }
  }

  /* Turns off backlight **/
  function turnOffBacklight() as Void {
    tryToggleBacklight(false);

    _turnOffBacklightAt = null;
  }

  function tryToggleBacklight(enable) {
    try {
      Attention.backlight(enable);
    } catch (ex) {}
  }
}

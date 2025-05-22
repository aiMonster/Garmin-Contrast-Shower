import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Attention;
import Toybox.Timer;
import Toybox.Time;

class NotificationManager {
  private var _timer = new Timer.Timer();

  private var _callbacks = [];

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
  }
}

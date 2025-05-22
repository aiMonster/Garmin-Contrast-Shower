import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;

class ContrastShowerApp extends Application.AppBase {
  private var _view;

  function initialize() {
    AppBase.initialize();
  }

  // onStart() is called on application start up
  function onStart(state as Dictionary?) as Void {}

  // onStop() is called when your application is exiting
  function onStop(state as Dictionary?) as Void {}

  // Return the initial view of your application here
  function getInitialView() as Array<Views or InputDelegates>? {
    var notificationManager = new NotificationManager();

    _view = new ContrastShowerView(notificationManager);

    return [_view, new ContrastShowerDelegate()] as Array<Views or InputDelegates>;
  }

  // Returns main view instance
  function getView() as Void {
    return _view;
  }
}

// Returns application instance
function getApp() as ContrastShowerApp {
  return Application.getApp() as ContrastShowerApp;
}

// Returns main view instance
function getView() as ContrastShowerView {
  return Application.getApp().getView();
}

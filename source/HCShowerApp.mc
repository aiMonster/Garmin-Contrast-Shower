import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;

class HCShowerApp extends Application.AppBase {
    private var _view;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        _view = new HCShowerView();

        return [_view, new HCShowerDelegate() ] as Array<Views or InputDelegates>;
    }

    // Returns main view instance
    function getView() as Void {
        return _view;
    }
}

// Returns application instance
function getApp() as HCShowerApp {
    return Application.getApp() as HCShowerApp;
}

// Returns main view instance
function getView() as HCShowerView {
    return Application.getApp().getView();
}
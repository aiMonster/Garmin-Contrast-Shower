import Toybox.WatchUi;
import Toybox.Graphics;

class ContrastShowerView extends WatchUi.View {
  private var _notificationManager;

  private var _typeTitleElement;
  private var _currentTimerElement;
  private var _cylclesLeftElement;
  private var _todElement;

  private var _is24Hour;

  // Constructor
  function initialize(notificationManager) {
    _notificationManager = notificationManager;

    View.initialize();
  }

  // Load your resources here
  function onLayout(dc as Dc) as Void {
    setLayout(Rez.Layouts.MainLayout(dc));

    _typeTitleElement = findDrawableById("type_title");
    _currentTimerElement = findDrawableById("current_timer");
    _cylclesLeftElement = findDrawableById("cylcles_left");
    _todElement = findDrawableById("time_of_the_day");

    _typeTitleElement.setColor(ColorManager.get(Graphics.COLOR_BLUE));
    _currentTimerElement.setColor(ColorManager.get(Graphics.COLOR_WHITE));
    _cylclesLeftElement.setColor(ColorManager.get(Graphics.COLOR_WHITE));
    _todElement.setColor(ColorManager.get(Graphics.COLOR_WHITE));

    updateDynamicData();

    _notificationManager.callEverySecond(method(:updateDynamicData));
  }

  // Called when this View is brought to the foreground. Restore
  // the state of this View and prepare it to be shown. This includes
  // loading resources into memory.
  function onShow() as Void {
    var deviceSettings = System.getDeviceSettings();
    _is24Hour = deviceSettings.is24Hour;

    var firstCycle = CyclesManager.getCycleByIndex(0);

    setTimerValue(firstCycle.duration);
    setWaterTypeValue(firstCycle.waterType);
    setCyclesValue(CyclesManager.getCyclesCount());

    updateDynamicData();
  }

  // Update the view
  function onUpdate(dc as Dc) as Void {
    // Call the parent onUpdate function to redraw the layout
    View.onUpdate(dc);
  }

  // Called when this View is removed from the screen. Save the
  // state of this View here. This includes freeing resources from
  // memory.
  function onHide() as Void {}

  // Updates cycles value on the view
  function setCyclesValue(cycles) as Void {
    var formattedValue = CyclesViewManager.formatCycles(cycles);
    _cylclesLeftElement.setText(formattedValue);

    WatchUi.requestUpdate();
  }

  // Updates water type value on the view
  function setWaterTypeValue(waterType as WaterType) as Void {
    var label = CyclesViewManager.getTypeLabel(waterType);
    var color = CyclesViewManager.getTypeColor(waterType);

    _typeTitleElement.setText(label);
    _typeTitleElement.setColor(color);

    WatchUi.requestUpdate();
  }

  // Updates timer value on the view
  function setTimerValue(value) as Void {
    var current = CyclesViewManager.formatTime(value / 60, value % 60);
    _currentTimerElement.setText(current);

    WatchUi.requestUpdate();
  }

  function updateDynamicData() {
    updateDateTime();

    WatchUi.requestUpdate();
  }

  function updateDateTime() {
    var time = System.getClockTime();

    if (_is24Hour) {
      _todElement.setText(time.hour + ":" + time.min.format("%02d"));
    } else {
      var period = time.hour >= 12 ? "PM" : "AM";
      var hour12 = time.hour % 12 == 0 ? 12 : time.hour % 12;

      _todElement.setText(hour12 + ":" + time.min.format("%02d") + " " + period);
    }
  }
}

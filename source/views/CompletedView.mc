import Toybox.WatchUi;
import Toybox.Graphics;

class CompletedView extends WatchUi.View {
    private var _completedLblElement;
    private var _tooltiipElement;
    private var _activeActionElement;
    private var _secondaryActionElement;
    private var _actionsLineElement;

    // Constructor
    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.CompletedLayout(dc));

        _completedLblElement = findDrawableById("completed_lbl");
        _tooltiipElement = findDrawableById("tooltip_lbl");
        _activeActionElement = findDrawableById("active_action");
        _secondaryActionElement = findDrawableById("secondary_action");
        _actionsLineElement = findDrawableById("actions_split_line");

        setViewElementsColors();
        setViewElementsVisability();
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);        
    }

    // Set view elements colors
    function setViewElementsColors() as Void {
        _completedLblElement.setColor(ColorManager.get(Graphics.COLOR_GREEN));
        _tooltiipElement.setColor(ColorManager.get(Graphics.COLOR_WHITE));
        _activeActionElement.setColor(ColorManager.get(Graphics.COLOR_WHITE));
        _secondaryActionElement.setColor(ColorManager.get(Graphics.COLOR_WHITE));
    }

    // Display appropriate elements on the view
    function setViewElementsVisability() as Void {
        if (ActivityManager.getRecordActivityFlag()) {
            _tooltiipElement.setVisible(false);
            _activeActionElement.setVisible(true);
            _secondaryActionElement.setVisible(true);
            _actionsLineElement.setVisible(true);
        } else {
            _tooltiipElement.setVisible(true);
            _activeActionElement.setVisible(false);
            _secondaryActionElement.setVisible(false);
            _actionsLineElement.setVisible(false);
        }
    }

    // Set selected action if activity has been recorder
    function setSaveAsActiveAction(saveSelected as Boolean) as Void {
        _activeActionElement.setText(saveSelected ? "Save" : "Discard");
        _secondaryActionElement.setText(saveSelected ? "Discard" : "Save");
        
        WatchUi.requestUpdate();
    }
}

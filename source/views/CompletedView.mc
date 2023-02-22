import Toybox.WatchUi;
import Toybox.Graphics;

class CompletedView extends WatchUi.View {
    private var _completedLblElement;
    private var _activeActionElement;
    private var _secondaryActionElement;

    // Constructor
    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.CompletedLayout(dc));

        _completedLblElement = findDrawableById("completed_lbl");
        _activeActionElement = findDrawableById("active_action");
        _secondaryActionElement = findDrawableById("secondary_action");

        setViewElementsColors();
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);        
    }

    // Set view elements colors
    function setViewElementsColors() as Void {
        _completedLblElement.setColor(ColorManager.get(Graphics.COLOR_GREEN));
        _activeActionElement.setColor(ColorManager.get(Graphics.COLOR_WHITE));
        _secondaryActionElement.setColor(ColorManager.get(Graphics.COLOR_WHITE));
    }

    // Set selected action if activity has been recorder
    function setSaveAsActiveAction(saveSelected as Boolean) as Void {
        _activeActionElement.setText(saveSelected ? "Save" : "Discard");
        _secondaryActionElement.setText(saveSelected ? "Discard" : "Save");
        
        WatchUi.requestUpdate();
    }
}

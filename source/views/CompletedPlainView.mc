import Toybox.WatchUi;
import Toybox.Graphics;

class CompletedPlainView extends WatchUi.View {
    private var _completedLblElement;
    private var _tooltiipElement;

    // Constructor
    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.CompletedPlainLayout(dc));

        _completedLblElement = findDrawableById("completed_lbl");
        _tooltiipElement = findDrawableById("tooltip_lbl");

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
        _tooltiipElement.setColor(ColorManager.get(Graphics.COLOR_WHITE));
    }
}

import Toybox.WatchUi;
import Toybox.Graphics;

class CompletedView extends WatchUi.View {
    // Constructor
    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.CompletedLayout(dc));

        findDrawableById("completed_lbl").setColor(ColorManager.get(Graphics.COLOR_GREEN));
        findDrawableById("tooltip_lbl").setColor(ColorManager.get(Graphics.COLOR_WHITE));
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }
}
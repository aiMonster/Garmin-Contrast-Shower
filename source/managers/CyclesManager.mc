import Toybox.Application;

class CyclesManager {
    static function getCycleByIndex(index as Number) as WaterCycle {
        var waterType = index % 2 == 0 ? WaterType.Hot : WaterType.Cold;
        var duration = getCycleDuration(waterType); 

        return new WaterCycle(waterType, duration);
    }

    static function getCycleDuration(waterType) {
        var key = waterType == WaterType.Hot ? "hotDuration" : "coldDuration";

        return Application.Properties.getValue(key);
    }

    static function setCycleDuration(waterType, duration) {
        var key = waterType == WaterType.Hot ? "hotDuration" : "coldDuration";
        
        Application.Properties.setValue(key, duration);
    }

    static function getCyclesCount() {
        return Application.Properties.getValue("cyclesCount");
    }

    static function setCyclesCount(count) {
        Application.Properties.setValue("cyclesCount", count);
    }
}
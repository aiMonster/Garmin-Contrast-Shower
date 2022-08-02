import Toybox.Application;

class CyclesManager {
    // HOT[0] - SWITCH[1] - COLD[2] - SWITCH[3] - HOT[4] - etc
    static function getCycleByIndex(index as Number) as WaterCycle {
        var waterType;

        if (index % 4 == 0) {
            waterType = WaterType.Hot;
        } else if (index % 2 == 0) {
            waterType = WaterType.Cold;
        } else {
            waterType = WaterType.Switch;
        }

        var duration = getCycleDuration(waterType); 

        return new WaterCycle(waterType, duration);
    }

    static function getCycleDuration(waterType) {
        var key = getWaterDurationKey(waterType);

        return Application.Properties.getValue(key);
    }

    static function setCycleDuration(waterType, duration) {
        var key = getWaterDurationKey(waterType);

        Application.Properties.setValue(key, duration);
    }

    static function getCyclesCount() {
        return Application.Properties.getValue("cyclesCount");
    }

    static function setCyclesCount(count) {
        Application.Properties.setValue("cyclesCount", count);
    }

    static function getWaterDurationKey(waterType) {
        switch(waterType) {
            case WaterType.Hot:
                return "hotDuration";
            case WaterType.Cold:
                return "coldDuration";
            case WaterType.Switch:
                return "switchDuration";
        }
    }
}
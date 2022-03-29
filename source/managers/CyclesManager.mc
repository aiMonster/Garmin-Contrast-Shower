class CyclesManager {
    private static var _hotDuration = 35;
    private static var _coldDuration = 25;
    private static var _cycles = 6;

    private static var cycles = [
        new WaterCycle(WaterType.Hot, 30),
        new WaterCycle(WaterType.Cold, 30),
        new WaterCycle(WaterType.Hot, 30),
        new WaterCycle(WaterType.Cold, 30),
        new WaterCycle(WaterType.Hot, 30),
        new WaterCycle(WaterType.Cold, 30)
    ];

    static function getCycleByIndex(index as Number) as WaterCycle {
        return cycles[index];
    }

    static function getCycleDuration(waterType) {
        return waterType == WaterType.Hot ? _hotDuration : _coldDuration;
    }

    static function setCycleDuration(waterType, duration) {
        if (waterType == WaterType.Hot) {
            _hotDuration = duration;
        } else {
            _coldDuration = duration;
        }
    }

    static function getCyclesCount() {
        return _cycles;
    }

    static function setCyclesCount(count) {
        _cycles = count;
    }
}
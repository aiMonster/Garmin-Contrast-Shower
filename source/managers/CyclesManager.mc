class CyclesManager {
    private static var cycles = [
        new WaterCycle(WaterType.Hot, 30),
        new WaterCycle(WaterType.Cold, 30),
        new WaterCycle(WaterType.Hot, 30),
        new WaterCycle(WaterType.Cold, 30),
        new WaterCycle(WaterType.Hot, 30),
        new WaterCycle(WaterType.Cold, 30)
    ];

    static function getCyclesCount() as Number {
        return cycles.size();
    }

    static function getFirstCycleDuration() as Number {
        return cycles[0].duration;
    }

    static function getFirstCycleType() as WaterType {
        return cycles[0].waterType;
    }

    static function getCycleByIndex(index as Number) as WaterCycle {
        return cycles[index];
    }
}
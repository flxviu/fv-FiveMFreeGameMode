Config = {}

Config.Exercises = {
    ["Flotari"] = {
        ["idleDict"] = "amb@world_human_push_ups@male@idle_a",
        ["idleAnim"] = "idle_c",
        ["actionDict"] = "amb@world_human_push_ups@male@base",
        ["actionAnim"] = "base",
        ["actionTime"] = 1100,
        ["enterDict"] = "amb@world_human_push_ups@male@enter",
        ["enterAnim"] = "enter",
        ["enterTime"] = 3050,
        ["exitDict"] = "amb@world_human_push_ups@male@exit",
        ["exitAnim"] = "exit",
        ["exitTime"] = 3400,
        ["actionProcent"] = 1,
        ["actionProcentTimes"] = 3,
    },
    ["Abdomene"] = {
        ["idleDict"] = "amb@world_human_sit_ups@male@idle_a",
        ["idleAnim"] = "idle_a",
        ["actionDict"] = "amb@world_human_sit_ups@male@base",
        ["actionAnim"] = "base",
        ["actionTime"] = 3400,
        ["enterDict"] = "amb@world_human_sit_ups@male@enter",
        ["enterAnim"] = "enter",
        ["enterTime"] = 4200,
        ["exitDict"] = "amb@world_human_sit_ups@male@exit",
        ["exitAnim"] = "exit", 
        ["exitTime"] = 3700,
        ["actionProcent"] = 1,
        ["actionProcentTimes"] = 10,
    },
    ["Bara"] = {
        ["idleDict"] = "amb@prop_human_muscle_chin_ups@male@idle_a",
        ["idleAnim"] = "idle_a",
        ["actionDict"] = "amb@prop_human_muscle_chin_ups@male@base",
        ["actionAnim"] = "base",
        ["actionTime"] = 3000,
        ["enterDict"] = "amb@prop_human_muscle_chin_ups@male@enter",
        ["enterAnim"] = "enter",
        ["enterTime"] = 1600,
        ["exitDict"] = "amb@prop_human_muscle_chin_ups@male@exit",
        ["exitAnim"] = "exit",
        ["exitTime"] = 3700,
        ["actionProcent"] = 1,
        ["actionProcentTimes"] = 10,
    },
}

Config.Locations = {
    {["x"] = -1204.6857910156, ["y"] = -1564.3032226562, ["z"] = 4.6097478866577 - 0.98, ["h"] = 214.37, ["exercise"] = "Bara"},
    {["x"] = -1199.9346923828, ["y"] = -1571.3096923828, ["z"] = 4.6095004081726 - 0.98, ["h"] = 44.260753631592, ["exercise"] = "Bara"},
	{["x"] = -1204.15234375, ["y"] = -1561.3779296875, ["z"] = 4.6264910697937 - 0.98, ["h"] = nil, ["exercise"] = "Flotari"},
    {["x"] = -1207.1727294922, ["y"] = -1560.7275390625, ["z"] = 5.0177788734436 - 0.98, ["h"] = 33.56797409056, ["exercise"] = "Abdomene"},
    {["x"] = -1195.1978759766, ["y"] = -1570.9835205078, ["z"] = 4.6181077957153 - 0.98, ["h"] = 302.19412231445, ["exercise"] = "Abdomene"},
    {["x"] = -1205.7413330078, ["y"] = -1568.1947021484, ["z"] = 4.6079921722412 - 0.98, ["h"] = 308.81399536133, ["exercise"] = "Abdomene"},
    {["x"] = -1204.2618408203, ["y"] = -1557.2844238281, ["z"] = 4.6190533638 - 0.98, ["h"] = 219.00923156738, ["exercise"] = "Abdomene"},
}
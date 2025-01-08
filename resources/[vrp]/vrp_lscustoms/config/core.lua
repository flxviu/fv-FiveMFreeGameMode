Config = Config or {}

-- The derailCard position on the top of the screen (0 = right, 1 = left)
Config.detailCardMenuPosition = 0

-- The cash amount position on the top of the screen (0 = right, 1 = left)
Config.cashPosition = 0

Config.Keys = {
    action = {key = 38, label = 'E', name = '~INPUT_PICKUP~'}
}

Config.DefaultActionDistance = 8.0

Config.DefaultBlip = {
    enable = true,
    type = 72,
    color = 0,
    title = 'Lucid Service',
    scale = 0.7
}

Config.Positions = {
    { -- bennys
        pos = {x = -212.1, y = -1324.24, z = 30.69},
        actionDistance = 7.0
    },

    { -- ls customs
        pos = {x = -338.93, y = -135.96, z = 38.33}
    },

    { -- paleto
        pos = {x = 110.89, y = 6626.35, z = 31.10}
    },
    
    { -- root 68
        pos = {x = 1174.93, y = 2639.62, z = 37.07}
    },

    { -- langa politie
        pos = {x = 732.85, y = -1086.29, z = 22.16}
    },

    { -- langa aeroport LS
        pos = {x = -1154.40, y = -2004.85, z = 13.18}
    },

    { -- Mecanici
        pos = {x = -144.62, y = -2130.09, z = 16.70}
    }
}

ServerConfig = ServerConfig or {}

Config.BobcatSecurity = {
    [1] = {
        ['Model'] = 'ig_casey',
        ['Coords'] = vector4(895.11, -2275.29, 30.47, 98.91),
    },
    [2] = {
        ['Model'] = 'ig_casey',
        ['Coords'] = vector4(894.94, -2287.58, 30.47, 46.99),
    },
    [3] = {
        ['Model'] = 'ig_casey',
        ['Coords'] = vector4(892.67, -2292.31, 30.47, 5.2),
    },
    [4] = {
        ['Model'] = 'ig_casey',
        ['Coords'] = vector4(891.4, -2283.48, 30.47, 334.42),
    },
}


Config.HeistRewards = {
    ['Housing'] = {
        ['Kitchen'] = {
            ['Min'] = 1, -- Minimum amount of items
            ['Max'] = 3, -- Maximum amount of items
            ['Items'] = {
                'cash-rolls'
            }
        },
        ['House'] = {
            ['Min'] = 0, -- Minimum amount of items
            ['Max'] = 2, -- Maximum amount of items
            ['Items'] = {
                'oxy',
                'cash-rolls'
            }
        },
        ['Bed'] = {
            ['Min'] = 1, -- Minimum amount of items
            ['Max'] = 2, -- Maximum amount of items
            ['Items'] = {
                'water',
                'electronics'
            }
        },
        ['Shower'] = {
            ['Min'] = 0, -- Minimum amount of items
            ['Max'] = 1, -- Maximum amount of items
            ['Items'] = {
                'lockpick',
                'phone'
            }
        },
    },
    ['Bobcat'] = {
        ['Min'] = 14, -- Minimum amount of items
        ['Max'] = 35, -- Maximum amount of items
        ['Items'] = {
            'cash-bands'
        }
    }
}

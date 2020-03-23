Config = {}
Config.Locale = 'pl'

Config.PoliceNumberRequired = 5
Config.TimerBeforeNewRob = 172800 -- sekundy (pod preferencje bulsona :D)


-- Change secondsRemaining if you want another timer
Banks = {
    ["humane_labs"] = {
        position = { ['x'] = 3560.48, ['y'] = 3669.39, ['z'] = 28.12 },
        reward =50000,
        nameofbank = "Humane Labs",
        secondsRemaining = 1800, -- seconds
        lastrobbed = 0     
    }
}

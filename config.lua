Config = {
    Settings = {
        RemoveWeapon = false,       -- Remove weapon when unauthorized (if false, just prevents firing)
        PreventFiring = true,      -- Prevent initial weapon firing
        NotifyPlayer = true,       -- Show notification to player
        CheckInterval = 200,       -- How often to check weapon when armed (ms)
        IdleInterval = 1000        -- How often to check when not armed (ms)
    },

    Notification = "Du hast keine Berechtigung, diese Waffe zu benutzen.",

    WeaponJobList = {
        ["WEAPON_PISTOL_MK2"] = {"police", "fib", "army"},
        ["WEAPON_SMG"] = {"police", "fib", "army"},
        ["WEAPON_HEAVYSNIPER_MK2"] = {"fib", "army"},
        ["WEAPON_PUMPSHOTGUN"] = {"police", "fib", "army"},
        ["WEAPON_CARBINERIFLE"] = {"police", "fib", "army"}
    }
}

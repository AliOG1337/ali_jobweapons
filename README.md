# ali_jobweapons

A FiveM resource for ESX that provides job-based weapon restrictions. Control which weapons are available to specific jobs with customizable settings and behavior.

## Features

- Job-based weapon permissions
- Configurable weapon restrictions
- Performance optimized with caching
- Customizable notification system
- Flexible configuration options

## Dependencies
- es_extended (ESX)

## Installation

1. Download the resource
2. Place it in your server's resources directory
3. Add `ensure ali_jobweapons` to your server.cfg
4. Configure the weapons and jobs in `config.lua`
5. Restart your server

## Configuration

### Weapon Settings
```lua
Config.Settings = {
    RemoveWeapon = true,       -- Remove weapon when unauthorized
    PreventFiring = true,      -- Prevent initial weapon firing
    NotifyPlayer = true,       -- Show notification to player
    CheckInterval = 200,       -- Check interval when armed (ms)
    IdleInterval = 1000        -- Check interval when idle (ms)
}
```

### Weapon Job List
```lua
Config.WeaponJobList = {
    ["WEAPON_PISTOL_MK2"] = {"police", "fib", "army"},
    ["WEAPON_SMG"] = {"police", "fib", "army"}
}
```

### Custom Notification
```lua
Config.Notification = "Du hast keine Berechtigung, diese Waffe zu benutzen."
```

## Usage

1. Configure the weapons and allowed jobs in `config.lua`
2. Adjust settings to your preferences
3. Any weapon not in the list will be available to all players
4. Players with unauthorized weapons will have them removed automatically

## Performance

- Efficient caching system for weapon permissions
- Optimized check intervals
- Minimal resource usage when idle
- Smart state tracking

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request

## Support

For support, create an issue in the GitHub repository or contact the developer.

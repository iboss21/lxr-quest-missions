# Dynamic NPC Location & Time System

## Overview
The bounty quest system now includes dynamic NPC spawning with randomly changing locations and time-based availability.

## Features

### 🌍 Multiple Spawn Locations
Each quest NPC can now spawn at multiple locations within their city:
- **Valentine Sheriff** - Rotates between Sheriff Office, Main Street, General Store, and Hotel
- **Strawberry Marshal** - Rotates between Marshal Office, Town Square, General Store, and Welcome Center
- **Rhodes Sheriff** - Rotates between Sheriff Office, Main Street, General Store, and Town Entrance
- **Saint Denis Police** - Rotates between Police Department, City Hall, Market District, and Harbor District
- **Blackwater Marshal** - Rotates between Marshal Office, Town Center, General Store, and Bank Plaza
- **Tumbleweed Hunter** - Rotates between Sheriff Office, Main Street, General Store, and Saloon

### ⏰ Time-Based Availability
NPCs now follow realistic schedules:
- **Valentine Sheriff**: Available 6:00 AM - 10:00 PM
- **Strawberry Marshal**: Available 7:00 AM - 9:00 PM
- **Rhodes Sheriff**: Available 6:00 AM - 11:00 PM
- **Saint Denis Police**: Available 24/7 (police work around the clock)
- **Blackwater Marshal**: Available 8:00 AM - 8:00 PM
- **Tumbleweed Hunter**: Available 5:00 AM - 11:00 PM (desert hunter works odd hours)

### 🔄 Automatic Location Changes
- NPCs automatically change their location every 20-40 minutes (randomized)
- Players are notified when an NPC moves to a new location
- Map blips update automatically to show current locations
- NPCs disappear during their off-hours and reappear when available

## Configuration

### Enable/Disable Dynamic Spawning
```lua
Config.NPCDynamicSpawn = {
    Enabled = true, -- Set to false to disable dynamic spawning
    ChangeInterval = 30, -- Base time in minutes before NPC changes location
    RandomTime = true, -- Randomize the change interval
    TimeRange = {min = 20, max = 40}, -- Random interval range (minutes)
}
```

### Adding New Spawn Locations
To add new locations for an NPC, edit the `spawnLocations` table in `config.lua`:

```lua
spawnLocations = {
    {coords = vector4(x, y, z, heading), city = 'CityName', location = 'Location Description'},
    -- Add more locations here
},
```

### Setting Time Restrictions
Configure when an NPC is available:

```lua
timeRestrictions = {
    startHour = 6, -- Available from 6:00 AM (24-hour format)
    endHour = 22, -- Available until 10:00 PM
    daysOfWeek = nil, -- nil = all days, or {0,1,2,3,4,5,6} where 0=Sunday
},
```

## Player Experience

### Finding NPCs
1. Check your map for the bounty quest blips
2. Travel to the marked location
3. If an NPC has moved, you'll see a notification with their new location
4. NPCs show their current location when you interact with them

### Time-Based Gameplay
- Plan your quest runs around NPC availability
- Some NPCs are available late at night, others early morning
- Saint Denis police are available 24/7 for urgent quests

### Location Variety
- NPCs appear in different spots around their cities
- Creates a more dynamic and realistic world
- Encourages exploration of different areas

## Technical Details

### Server-Side Logic
- Server maintains the current location of all NPCs
- Locations are randomly selected from the available spawn points
- Time checks use in-game clock (GetClockHours)
- Clients sync locations when they join

### Client-Side Logic
- Clients request NPC locations on load
- NPCs are spawned at their current locations
- Blips are updated when NPCs move
- Old NPCs are removed and new ones spawned at new locations

### Performance
- Location checks run every minute on server
- Client-side checks only run when player is near NPCs
- Minimal performance impact

## Troubleshooting

### NPCs Not Spawning
- Check if the current in-game time is within the NPC's availability window
- Verify `Config.NPCDynamicSpawn.Enabled = true`
- Check server console for errors

### NPCs Not Moving
- Ensure random time is enabled and interval is set correctly
- Check if enough time has passed since last location change
- Enable debug mode: `Config.EnableDebug = true`

### Blips Not Updating
- Make sure clients have synced with server
- Restart the resource if necessary
- Check for client-side console errors

## Commands

No new commands are required. The system works automatically.

## Debugging

Enable debug mode to see detailed logs:
```lua
Config.EnableDebug = true
```

This will show:
- When NPCs change locations
- Current NPC locations on server startup
- When NPCs are spawned/removed on client
- Location sync events

## Future Enhancements

Potential additions:
- Weather-based NPC availability
- Event-based special NPC spawns
- Reputation-based NPC unlock system
- Custom NPC patrol routes between locations
- Player influence on NPC schedules

---

© 2026 iBoss21 / The Lux Empire | wolves.land

# Pokemon Game Supabase Integration Setup Guide

This guide will help you integrate your Godot Pokemon game with Supabase database for player statistics, battle logging, and game saves.

## Prerequisites

1. A Supabase account (free tier available at https://supabase.com)
2. Your Godot Pokemon game project
3. Vercel account for deployment (you already have this)

## Step 1: Set up Supabase Database

### 1.1 Create a new Supabase project
1. Go to https://supabase.com and sign in
2. Click "New Project"
3. Choose your organization and enter project details
4. Wait for the project to be created (this may take a few minutes)

### 1.2 Create the database structure
1. In your Supabase dashboard, go to the SQL Editor
2. Copy and paste the contents of `supabase_setup.sql` and run it
3. This will create the following tables:
   - `players` - User accounts and basic stats
   - `pokemon_stats` - Caught/owned Pokemon data
   - `battle_logs` - Battle history and results
   - `game_saves` - Game save states

### 1.3 Get your Supabase credentials
1. In your Supabase dashboard, go to Settings > API
2. Copy your Project URL (looks like: `https://your-project-id.supabase.co`)
3. Copy your `anon` `public` key (the long string under "Project API keys")

## Step 2: Configure the Godot Project

### 2.1 Update Supabase configuration
1. Open `Scenes/Global/supabase_manager.gd`
2. Replace the placeholder values:
   ```gdscript
   const SUPABASE_URL = "https://your-project-id.supabase.co"  # Your actual URL
   const SUPABASE_ANON_KEY = "your-anon-key-here"  # Your actual anon key
   ```

### 2.2 Test the integration
1. Open your project in Godot
2. Run the project (F5)
3. You should see a login screen instead of the main menu
4. Try creating a new username - this should create a player in your database
5. Check your Supabase dashboard > Table Editor > players table to verify

## Step 3: Deploy to Vercel

### 3.1 Export your Godot project
1. In Godot, go to Project > Export
2. Add a Web export preset if you don't have one
3. Export to your `exports/web/` folder
4. Make sure all the new files are included

### 3.2 Update your repository
```bash
git add .
git commit -m "Add Supabase database integration"
git push origin main
```

### 3.3 Vercel will automatically deploy your updated game

## Step 4: Set up Environment Variables (Optional Security Enhancement)

For better security, you can move your Supabase credentials to environment variables:

### 4.1 In Vercel Dashboard
1. Go to your project settings
2. Add environment variables:
   - `SUPABASE_URL`: Your project URL
   - `SUPABASE_ANON_KEY`: Your anon key

### 4.2 Update your Godot script (for advanced users)
You'd need to modify the Supabase manager to read from environment variables when deployed.

## Features Added

### Player System
- Login/Registration with usernames
- Persistent player statistics
- Battle win/loss tracking
- Automatic save system every 30 seconds

### Database Integration
- Player profiles with battle statistics
- Battle history logging
- Pokemon collection tracking (ready for future features)
- Game state saving

### New Screens
- Login screen (now the starting screen)
- Player statistics screen accessible from main menu

## Testing Your Integration

1. **Create a Player**: Enter a username and register
2. **Battle**: Start a battle and either win, lose, or run away
3. **Check Stats**: Go to the stats screen from main menu
4. **Verify Database**: Check your Supabase dashboard to see the data

## Troubleshooting

### Common Issues

1. **"Please configure your Supabase URL"**
   - Make sure you've updated the SUPABASE_URL and SUPABASE_ANON_KEY in `supabase_manager.gd`

2. **HTTP errors**
   - Check your Supabase project is running
   - Verify your API key is correct
   - Check the browser console for detailed error messages

3. **No data appearing**
   - Verify the SQL setup script ran successfully
   - Check the Row Level Security policies are set correctly

### Debug Mode
Add this to see HTTP requests in the Godot console:
```gdscript
# In supabase_manager.gd _on_request_completed function
print("HTTP Response: ", response_code, " - ", response_text)
```

## Next Steps (Future Enhancements)

1. **Pokemon Collection**: Track caught Pokemon
2. **Leaderboards**: Global player rankings
3. **Real-time Battles**: Multiplayer functionality
4. **Cloud Saves**: Load game from any device
5. **Daily Challenges**: Time-based events

## Database Schema

```sql
Players Table:
- id (UUID, Primary Key)
- username (TEXT, Unique)
- total_battles (INTEGER)
- wins (INTEGER)
- losses (INTEGER)
- created_at, last_played (TIMESTAMPS)

Battle Logs Table:
- id (UUID, Primary Key)
- player_id (UUID, Foreign Key)
- opponent_pokemon (TEXT)
- player_pokemon (TEXT)
- battle_result (win/loss/flee)
- battle_duration (INTEGER, seconds)
- experience_gained (INTEGER)
- created_at (TIMESTAMP)

Pokemon Stats Table:
- id (UUID, Primary Key)
- player_id (UUID, Foreign Key)
- pokemon_name, pokemon_id
- level, hp, max_hp, attack, defense, speed
- experience, caught_at

Game Saves Table:
- id (UUID, Primary Key)
- player_id (UUID, Foreign Key)
- save_data (JSONB)
- save_name (TEXT)
- created_at, updated_at (TIMESTAMPS)
```

Your Pokemon game now has a persistent backend! Players can track their progress, battle statistics are logged, and you have the foundation for many more features.
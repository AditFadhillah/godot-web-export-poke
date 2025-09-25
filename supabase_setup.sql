-- Pokemon Game Database Setup for Supabase
-- Run this in your Supabase SQL Editor

-- Create players table
CREATE TABLE players (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  username TEXT NOT NULL UNIQUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  last_played TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  total_battles INTEGER DEFAULT 0,
  wins INTEGER DEFAULT 0,
  losses INTEGER DEFAULT 0
);

-- Create pokemon_stats table (for caught/owned pokemon)
CREATE TABLE pokemon_stats (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  player_id UUID REFERENCES players(id) ON DELETE CASCADE,
  pokemon_name TEXT NOT NULL,
  pokemon_id INTEGER NOT NULL,
  level INTEGER DEFAULT 1,
  hp INTEGER NOT NULL,
  max_hp INTEGER NOT NULL,
  attack INTEGER NOT NULL,
  defense INTEGER NOT NULL,
  speed INTEGER NOT NULL,
  experience INTEGER DEFAULT 0,
  caught_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create battle_logs table
CREATE TABLE battle_logs (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  player_id UUID REFERENCES players(id) ON DELETE CASCADE,
  opponent_pokemon TEXT NOT NULL,
  player_pokemon TEXT NOT NULL,
  battle_result TEXT CHECK (battle_result IN ('win', 'loss', 'flee')),
  battle_duration INTEGER, -- in seconds
  experience_gained INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create game_saves table (for save states)
CREATE TABLE game_saves (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  player_id UUID REFERENCES players(id) ON DELETE CASCADE,
  save_data JSONB NOT NULL, -- Store game state as JSON
  save_name TEXT DEFAULT 'Auto Save',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Insert some sample data
INSERT INTO players (username, total_battles, wins, losses)
VALUES 
  ('TrainerAsh', 15, 12, 3),
  ('PokeMaster', 8, 6, 2),
  ('RocketTeam', 3, 1, 2);

-- Enable Row Level Security
ALTER TABLE players ENABLE ROW LEVEL SECURITY;
ALTER TABLE pokemon_stats ENABLE ROW LEVEL SECURITY;
ALTER TABLE battle_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE game_saves ENABLE ROW LEVEL SECURITY;

-- Create policies for public read access (you may want to restrict this later)
CREATE POLICY "Players can read all player data" ON players FOR SELECT USING (true);
CREATE POLICY "Players can insert their own data" ON players FOR INSERT WITH CHECK (true);
CREATE POLICY "Players can update their own data" ON players FOR UPDATE USING (true);

CREATE POLICY "Pokemon stats are readable" ON pokemon_stats FOR SELECT USING (true);
CREATE POLICY "Players can insert pokemon stats" ON pokemon_stats FOR INSERT WITH CHECK (true);

CREATE POLICY "Battle logs are readable" ON battle_logs FOR SELECT USING (true);
CREATE POLICY "Players can insert battle logs" ON battle_logs FOR INSERT WITH CHECK (true);

CREATE POLICY "Game saves are readable" ON game_saves FOR SELECT USING (true);
CREATE POLICY "Players can manage their saves" ON game_saves FOR ALL USING (true);
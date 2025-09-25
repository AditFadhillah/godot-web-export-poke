# Pokemon Clone - Godot Game with Supabase Integration

A Pokemon-inspired game built with Godot 4.x, featuring database integration with Supabase for player statistics and battle logging.

## 🎮 Live Demo
**Play the game**: https://godot-web-export-poke.vercel.app/Pokemon_Clone.html

## 🚀 Features

### Game Features
- Classic Pokemon battle system
- Player vs Wild Pokemon encounters
- Multiple attack types and animations
- Background music and sound effects
- Responsive pixel-art style graphics

### Database Features (NEW!)
- **Player Registration/Login**: Create and manage player accounts
- **Battle Statistics**: Track wins, losses, and win rates
- **Battle History**: View recent battle results
- **Auto-Save**: Automatic game state saving every 30 seconds
- **Player Profiles**: Persistent player data across sessions

## 🛠️ Tech Stack
- **Game Engine**: Godot 4.x
- **Database**: Supabase (PostgreSQL)
- **Deployment**: Vercel
- **Version Control**: Git/GitHub

## 📊 Database Schema
- `players` - User accounts and statistics
- `battle_logs` - Battle history and results
- `pokemon_stats` - Pokemon collection data
- `game_saves` - Save states and progress

## 🔧 Setup Instructions

### For Players
1. Visit the live demo link above
2. Enter a username to create your account
3. Start battling and track your progress!

### For Developers
1. Clone this repository
2. Follow the detailed setup guide in `SUPABASE_SETUP_GUIDE.md`
3. Configure your Supabase credentials
4. Run in Godot or deploy to Vercel

## 📈 Game Statistics
- Player registration and authentication
- Real-time battle result tracking
- Win/loss ratio calculations
- Battle history with opponent details
- Persistent game progress

------------------------------------------------------------

## Development Commands

------------------------------------------------------------

# Install dependencies (first time or after updating package.json)
npm install

# Start development server with hot reload
npm run dev

# Build production-ready files (output in dist/)
npm run build

# Preview the production build locally
npm run preview

# GITHUB
# Initialize repo (first time)
git init

# Add all changes
git add .

# Or add specific file
git add src/ui/App.tsx

# Commit with message
git commit -m "message"

# Push to remote (after git remote add origin …)
git push origin main

# Pull latest changes
git pull origin main

# Check remote URL
git remote -v

# Check repo status (changed files, branch)
git status

# See changes in detail
git diff

# Create new branch
git checkout -b feature-battle-system

# Switch to another branch
git checkout main

# List all branches
git branch

# Push new branch to GitHub
git push -u origin feature-battle-system

# Merge feature branch into main
git checkout main
git pull origin main
git merge feature-battle-system

# Delete branch locally
git branch -d feature-battle-system

# Delete branch on GitHub
git push origin --delete feature-battle-system

# Unstage a file (remove from git add)
git reset HEAD <file>

# Discard changes in a file (CAREFUL: irreversible)
git checkout -- <file>

# Amend the last commit (e.g., fix commit message)
git commit --amend

# Revert a commit by creating a new "undo" commit
git revert <commit-hash>

# Reset to a previous commit (dangerous: rewrites history)
git reset --hard <commit-hash>

# View commit history (short)
git log --oneline

# View commit history with branches
git log --graph --oneline --all

# Show last commit details
git show HEAD


# ''''''''''''''''''''''''''''''''''''''''
git add .
git commit -m "attempt 4: sending battle signal"
git push origin main

npm run build
npm run deploy
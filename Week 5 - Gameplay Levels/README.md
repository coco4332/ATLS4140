# ATLS 4140 - Game Development Week 4 - Adding Juice

### HUD
Time spent: ~2 hrs

- Built a HUD on a CanvasLayer so it stays fixed on screen regardless of the camera
- Moved the XP bar and level number into a bottom HUD bar using containers
- Added an ability bar with spell and summon icons pulled from an icon spritesheet
- Added keybind labels (LMB / RMB) to each ability slot
- Added radial cooldown that animate when an ability is used
- Split the shared cast timer into separate spell and summon cooldowns

### World & Environment
Time spent: ~1 hr

- Replaced the flat background with a painted tilemap using Ground and Details layers
- Set up trees as single multi-cell tiles for easier placement
- Added trunk collision on a dedicated Environment physics layer
- Added Y-sorting so the player and enemies can walk behind trees

### Sound
Time spent: ~1.5 hrs

- Set up separate Music and SFX audio buses
- Added a looping forest ambience track
- Added sound effects for spell casts, summons, orc hits and deaths, player damage, footsteps, level up, and game over

### Progression & Fixes
Time spent: ~30 mins

- Locked the summon ability until level 2, with the ability slot dimmed until it unlocks
- Fixed the level 6 speed buff not applying to player movement
- Fixed footstep audio not playing or stopping correctly
- Fixed the HUD health bar being connected to the wrong signal
- Fixed file path capitalization issues that would break exports on case-sensitive platforms

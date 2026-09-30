# ATLS 4140 - Game Development Week 5 - Gameplay Levels

### Level Design & Tilemaps
Time spent: ~4 hrs

- Built the first handcrafted map (map_1) using the Cainos top down tileset
- Split the map into Ground, Shadows, WallsBack, World, and WallsFront layers so each type of tile draws in the right order
- Set up Y-sorting in the World node so the player, trees, and tower walk behind and in front of each other correctly
- Tuned Y Sort Origins and Texture Origins on merged tiles so the tower lines up with the grid and sorts by its base
- Added a separate TowerTops layer with its own Y sort offset so the tower roof hides the player correctly
- Split perimeter walls into back and front layers outside the Y sort, so outer walls always draw under or over the player
- Separated wall tops and wall faces onto their own layers to fix overlapping tiles alternating draw order
- Saved tower and roof tile groups as TileSet patterns for faster placement
- Added wall collision through TileSet physics layers

### Door & Map Completion
Time spent: ~1 hrs

- Created a reusable Door scene with closed and open sprites and a collision shape
- Door stays locked until the player reaches the required level (set to 5 in the Inspector)
- Level ups announce themselves to every door using a "doors" group, so any number of doors can be added without extra code
- Added a FinishLine trigger past the door that shows a Map Complete screen and pauses the game
- Added an on screen message at the start of the map explaining how to beat it

### Player
Time spent: ~30min

- Player sprite now flips horizontally to face the direction it's walking

### Fixes
Time spent: ~30min

- Fixed mobs not spawning in the new map by reconnecting the SpawnTimer timeout signal
- Reconnected the player health, game over, and ability cooldown signals that were lost when moving to the new map scene

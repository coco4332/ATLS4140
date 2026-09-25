extends Node2D

var XP = 0
var level = 1
var elite_mob = false

const ORC = preload("res://orc_mob.tscn")
const ELITE_ORC = preload("res://elite_orc.tscn")

func spawn_mob():
	var new_mob = (ELITE_ORC if elite_mob else ORC).instantiate()
	new_mob.died.connect(_on_mob_died)
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)
	
func _on_timer_timeout():
	spawn_mob()

func _on_player_health_depleted() -> void:
	%GameOver.visible = true
	get_tree().paused = true

func _on_mob_died(xp_value):
	%XPBar.value += xp_value
	if %XPBar.value == %XPBar.max_value:
		level += 1
		%XPBar.value = 0
		%XPBar.max_value += 100
		%XPBar.update_maximum_size()
		%LevelNumber.text = str(level)
		show_level_up(level)
		
var level_up
var level_up_buff

func show_level_up(level):
	if level_up and level_up.is_running():
		level_up.kill()
	if level_up_buff and level_up_buff.is_running():
		level_up_buff.kill()

	%LevelUpLabel.modulate.a = 1.0
	%LevelUpLabel.visible = true

	level_up = create_tween()
	level_up.tween_interval(3)
	level_up.tween_property(%LevelUpLabel, "modulate:a", 0.0, 0.4)
	level_up.tween_callback(func(): %LevelUpLabel.visible = false)
	
	if level == 2:
		%LevelUpBuffs.text = "New Summon Ability Unlocked With RMB! Increase Spawn Rate!"
		%SpawnTimer.wait_time = 0.8
		%LevelUpBuffs.modulate.a = 1.0
		%LevelUpBuffs.visible = true
		level_up_buff = create_tween()
		level_up_buff.tween_interval(3)
		level_up_buff.tween_property(%LevelUpBuffs, "modulate:a", 0.0, 0.4)
		level_up_buff.tween_callback(func(): %LevelUpBuffs.visible = false)
	
	if level%4 == 0:
		%LevelUpBuffs.text = "Health Increased! Increase Spawn Rate!"
		%SpawnTimer.wait_time = 0.7
		%Player.health += 50
		%LevelUpBuffs.modulate.a = 1.0
		%LevelUpBuffs.visible = true
		level_up_buff = create_tween()
		level_up_buff.tween_interval(3)
		level_up_buff.tween_property(%LevelUpBuffs, "modulate:a", 0.0, 0.4)
		level_up_buff.tween_callback(func(): %LevelUpBuffs.visible = false)
	
	if level == 5:
		%LevelUpBuffs.text = "Elite Orcs, Uh Oh! Increase Spawn Rate!"
		elite_mob = true
		%SpawnTimer.wait_time = 0.5
		%LevelUpBuffs.modulate.a = 1.0
		%LevelUpBuffs.visible = true
		level_up_buff = create_tween()
		level_up_buff.tween_interval(3)
		level_up_buff.tween_property(%LevelUpBuffs, "modulate:a", 0.0, 0.4)
		level_up_buff.tween_callback(func(): %LevelUpBuffs.visible = false)
	
	if level%6 == 0:
		%LevelUpBuffs.text = "Speed Increased! Increase Spawn Rate!"
		%SpawnTimer.wait_time = 0.2
		%Player.speed_multipler = 1.5
		%LevelUpBuffs.modulate.a = 1.0
		%LevelUpBuffs.visible = true
		level_up_buff = create_tween()
		level_up_buff.tween_interval(3)
		level_up_buff.tween_property(%LevelUpBuffs, "modulate:a", 0.0, 0.4)
		level_up_buff.tween_callback(func(): %LevelUpBuffs.visible = false)
	
	
			

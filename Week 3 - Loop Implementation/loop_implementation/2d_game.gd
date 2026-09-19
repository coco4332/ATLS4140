extends Node2D

var XP = 0
var level = 1
	
func spawn_mob():
	var new_mob = preload("res://orc_mob.tscn").instantiate()
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
		show_level_up()
		%XPBar.value = 0
		%XPBar.max_value += 100
		%XPBar.update_maximum_size()
		level += 1
		%LevelNumber.text = str(level)
		level_up_bonus(level)
		

var level_up

func show_level_up():
	if level_up and level_up.is_running():
		level_up.kill()
	
	%LevelUpLabel.text = "Level Up! "
	%LevelUpLabel.modulate.a = 1.0
	%LevelUpLabel.visible = true

	level_up = create_tween()
	level_up.tween_interval(1.5)
	level_up.tween_property(%LevelUpLabel, "modulate:a", 0.0, 0.4)
	level_up.tween_callback(func(): %LevelUpLabel.visible = false)
		
func level_up_bonus(level):
	match level:
		2:
			%LevelUpLabel.text += " New Summon Ability Unlocked!"
			level_up = create_tween()
			level_up.tween_interval(1.5)
			level_up.tween_property(%LevelUpLabel, "modulate:a", 0.0, 0.4)
			level_up.tween_callback(func(): %LevelUpLabel.visible = false)
		_:
			print("no upgrade for this level")
			

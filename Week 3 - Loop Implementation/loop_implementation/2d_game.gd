extends Node2D

var XP = 0
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

extends Area2D

signal casted
signal summoned
signal cooldown_started(ability, duration)

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
		
func shoot():
	casted.emit()
	const SPELL = preload("res://scenes/spell.tscn")
	var spell = SPELL.instantiate()
	spell.spawn_position = get_global_mouse_position()
	get_tree().current_scene.add_child(spell)

func summon():
	summoned.emit()
	const SUMMON = preload("res://scenes/summon.tscn")
	var summon = SUMMON.instantiate()
	summon.spawn_position = get_global_mouse_position()
	get_tree().current_scene.add_child(summon)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("primary") and $SpellTimer.is_stopped():
		shoot()
		$SpellTimer.start()
		cooldown_started.emit("spell", $SpellTimer.wait_time)

	if event.is_action_pressed("secondary") and $SummonTimer.is_stopped():
		summon()
		$SummonTimer.start()
		cooldown_started.emit("summon", $SummonTimer.wait_time)
		



		

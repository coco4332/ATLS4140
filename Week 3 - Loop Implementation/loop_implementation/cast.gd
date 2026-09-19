extends Area2D

signal casted

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
		
func shoot():
	casted.emit()
	const SPELL = preload("res://spell.tscn")
	var spell = SPELL.instantiate()
	spell.global_position = %ShootingPoint.global_position
	spell.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(spell)

func summon():
	casted.emit()
	const SUMMON = preload("res://summon.tscn")
	var summon = SUMMON.instantiate()
	summon.spawn_position = get_global_mouse_position()
	get_tree().current_scene.add_child(summon)
	var mp = get_global_mouse_position()
	print("player pos: ", global_position, " | mouse: ", mp)
	summon.spawn_position = mp
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("primary") and $Timer.is_stopped():
		shoot()
		$Timer.start()
	
	if event.is_action_pressed("secondary") and $Timer.is_stopped():
		summon()
		var mp = get_global_mouse_position()
		print("player pos: ", global_position, " | mouse: ", mp)
		$Timer.start()
		

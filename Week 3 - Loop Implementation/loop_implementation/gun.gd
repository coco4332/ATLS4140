extends Area2D

signal fired

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
		
func shoot():
	fired.emit()
	const BULLET = preload("res://bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_bullet)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot") and $Timer.is_stopped():
		shoot()
		$Timer.start()
		

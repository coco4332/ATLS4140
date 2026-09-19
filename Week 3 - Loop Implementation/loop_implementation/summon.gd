extends Area2D

var travelled_distance = 0
var hit = false

func _physics_process(delta: float) -> void:
	%SummonCircle.play("default")
	position = get_global_mouse_position()
	%SummonCircle.global_rotation = 0
	await %SummonCircle.animation_finished
	queue_free()
	

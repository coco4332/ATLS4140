extends Area2D

var travelled_distance = 0
var hit = false

func _physics_process(delta: float) -> void:
	%Spell.play("default")
	if hit:
		return
	var SPEED = 1000
	var RANGE = 1200

	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	%Spell.global_rotation = 0
	await %Spell.animation_finished
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if hit:
		return
	hit = true
	%CollisionShape2D.set_deferred("disabled", true)
	await explode()

func explode() -> void:
	%BlastArea/CollisionShape2D.set_deferred("disabled", false)
	await get_tree().physics_frame
	await get_tree().physics_frame
	
	var bodies = %BlastArea.get_overlapping_bodies()

	for target in bodies:
		if target.has_method("take_damage"):
			target.take_damage()
	

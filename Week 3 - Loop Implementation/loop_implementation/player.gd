extends CharacterBody2D

signal health_depleted

var health = 100.0
var is_attacking = false

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * 100
	move_and_slide()
	
	if not is_attacking:
		if velocity.length() > 0.0:
			%Necromancer.play("walk")
		else:
			%Necromancer.play("idle")
	
	const DAMAGE_RATE = 5.0
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size()*delta
		%HealthBar.value = health
		if health <= 0.0:
			health_depleted.emit()
	
func attack():
	is_attacking = true
	%Necromancer.play("attack")
	await %Necromancer.animation_finished
	is_attacking = false


func _on_gun_fired() -> void:
	is_attacking = true
	%Necromancer.play("attack")
	await %Necromancer.animation_finished
	is_attacking = false

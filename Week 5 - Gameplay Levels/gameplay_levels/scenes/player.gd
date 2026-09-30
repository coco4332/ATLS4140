extends CharacterBody2D

signal health_depleted
var is_attacking = false
var speed_multipler = 1

signal health_changed(current, max_hp)

var max_health = 100.0
var health = 100.0:
	set(value):
		health = clamp(value, 0, max_health)
		health_changed.emit(health, max_health)

func _ready():
	health_changed.emit(health, max_health)
	
func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * 100 * speed_multipler
	move_and_slide()

	if velocity.length() > 0.0:
		if not %WalkSound.playing:
			%WalkSound.play()
	else:
		%WalkSound.stop()

	if not is_attacking:
		if velocity.length() > 0.0:
			%Necromancer.play("walk")
		else:
			%Necromancer.play("idle")
	
	const DAMAGE_RATE = 5.0
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size()*delta
		if not %HitSound.playing:
			%HitSound.play()
		%HealthBar.value = health
		if health <= 0.0:
			health_depleted.emit()
	
func attack():
	is_attacking = true
	%Necromancer.play("attack")
	await %Necromancer.animation_finished
	is_attacking = false

func _on_spells_casted() -> void:
	is_attacking = true
	%Necromancer.play("attack")
	await %Necromancer.animation_finished
	is_attacking = false
	
func _on_spells_summoned() -> void:
	is_attacking = true
	%Necromancer.play("summon")
	await %Necromancer.animation_finished
	is_attacking = false

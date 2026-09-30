extends StaticBody2D

@export var required_level := 3

@onready var closed_sprite: Sprite2D = $Closed
@onready var open_sprite: Sprite2D = $Open
@onready var collision: CollisionShape2D = $CollisionShape2D

var is_open := false


func _ready() -> void:
	add_to_group("doors")
	open_sprite.visible = false


func on_level_changed(new_level: int) -> void:
	if is_open or new_level < required_level:
		return
	open()


func open() -> void:
	is_open = true
	closed_sprite.visible = false
	open_sprite.visible = true
	collision.set_deferred("disabled", true)

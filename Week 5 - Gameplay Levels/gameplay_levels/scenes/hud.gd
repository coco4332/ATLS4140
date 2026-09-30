extends CanvasLayer

func _ready():
	%SummonSlot.modulate = Color(0.3, 0.3, 0.3)

func unlock_summon():
	var tween = create_tween()
	tween.tween_property(%SummonSlot, "modulate", Color.WHITE, 0.5)

func _on_player_health_changed(current: Variant, max_hp: Variant) -> void:
	%HealthBar.max_value = max_hp
	%HealthBar.value = current


func _on_spells_cooldown_started(ability: Variant, duration: Variant) -> void:
	var slot = %SpellSlot if ability == "spell" else %SummonSlot
	slot.value = slot.max_value
	var tween = create_tween()
	tween.tween_property(slot, "value", 0.0, duration)

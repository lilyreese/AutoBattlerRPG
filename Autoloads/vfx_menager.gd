class_name VFX_Menager extends Node

const DAMAGE_NUMBER_PACKED_SCENE = preload("res://Interface/damage_number.tscn")

func play_vfx_at_position(vfx:PackedScene, pos:Vector2):
	var vfx_node:CPUParticles2D = vfx.instantiate() as CPUParticles2D
	vfx_node.global_position = pos
	add_child(vfx_node)
	vfx_node.emitting = true
	vfx_node.one_shot = true
	vfx_node.finished.connect(func():vfx_node.queue_free())
	
func show_damage_number_at_position(_position:Vector2, value:int):
	var damage_number:Label = DAMAGE_NUMBER_PACKED_SCENE.instantiate()
	damage_number.text = str(value)
	damage_number.pivot_offset = damage_number.size / 2
	damage_number.position = _position
	add_child(damage_number)
	
	var tween:Tween = get_tree().create_tween()
	tween.tween_property(damage_number, "position:y", damage_number.position.y - 30, 0.5)
	tween.tween_property(damage_number, "modulate:a", 0, 0.5)
	tween.finished.connect(func():damage_number.queue_free())

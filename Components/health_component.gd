class_name Health_Component extends Node

signal on_death()

@onready var damage_position:Node2D = $DamagePosition

@export var max_health:int = 10
@export var death_sound:AudioStream
@export var death_effect_scene:PackedScene

var current_health:int = 0

func _ready():
	current_health = max_health
	
func apply_damage(damage:int):
	current_health -= damage
	VfxMenager.show_damage_number_at_position(get_parent().global_position + damage_position.global_position, damage)
	if current_health <= 0:
		_die()
		
func _die():
	SfxMenager.play_sfx_at_position(death_sound, get_parent().global_position)
	VfxMenager.play_vfx_at_position(death_effect_scene, get_parent().global_position)
	on_death.emit()
	

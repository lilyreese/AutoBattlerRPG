class_name Base_Combo_Action extends Node2D

@export var hitbox_component:Hitbox_Component

func set_action_damage(_damage:int):
	hitbox_component.damage = _damage

func combo_action_sfx(sfx:AudioStream):
	SfxMenager.play_sfx_at_position(sfx, global_position)

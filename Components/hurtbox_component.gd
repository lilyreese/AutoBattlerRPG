class_name Hurtbox_Component extends Area2D

@export var health_component:Health_Component

func _ready():
	if !health_component:
		push_error(str(get_parent().name, "No health component associated with Hurtbox. Component will instantly die."))

func _on_area_entered(area):
	if not area is Hitbox_Component:
		return
	var hitbox:Hitbox_Component = area as Hitbox_Component

	if !health_component:
		get_parent().queue_free()
		return
		
	health_component.apply_damage(hitbox.damage)
	
	

class_name Base_Enemy extends CharacterBody2D

@export var health_component:Health_Component
@export var move_speed:float = 50
@export var exp_value:int = 2

func _ready():
	if !health_component:
		if find_child("HealthComponent"):
			health_component = find_child("HealthComponent")
		
	if health_component:
		health_component.on_death.connect(_on_death)
		
func _physics_process(delta):
	velocity.x = -move_speed
	move_and_slide()
	
func _on_death():
	WaveMenager.enemy_defeated.emit(exp_value)
	queue_free()

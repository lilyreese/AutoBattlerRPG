class_name Enemy_Spawner extends Node2D

@onready var spawn_timer:Timer = $SpawnTimer
@onready var enemy_container:Node = $EnemyContainer

@export var enemy_types:Array[PackedScene]


func _on_spawn_timer_timeout():
	_spawn_enemy()
	
func _spawn_enemy():
	var enemy:Base_Enemy = enemy_types.pick_random().instantiate() as Base_Enemy
	enemy_container.add_child(enemy)
	enemy.global_position = global_position	

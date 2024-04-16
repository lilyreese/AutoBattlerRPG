extends Control

@export var player_menager:Player_Menager

@onready var grid_container:GridContainer = $GridContainer

var grid_container_items:Array[CA_Inventory_Slot] = []
# Called when the node enters the scene tree for the first time.
func _ready():
	for rect in grid_container.get_children():
		if not rect is CA_Inventory_Slot:
			rect.queue_free()
			continue
		grid_container_items.append(rect)
		
	if !player_menager:
		return
		
	var i:int = 0
	for combo_action in player_menager.available_combo_action_array:
		grid_container_items[i].combo_action_resource = combo_action
		grid_container_items[i].texture = combo_action.action_icon
		i += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

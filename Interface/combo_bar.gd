class_name Combo_Bar extends Control

signal combo_bar_changed(combo_bar_array:Array[Combo_Action_Resource])

var combo_slots:Array[Combo_Bar_Slot] = []

var combo_bar_array:Array[Combo_Action_Resource] = [null, null, null, null, null]
# Called when the node enters the scene tree for the first time.
func _ready():
	for slot:Combo_Bar_Slot in $VBoxContainer.get_children():
		combo_slots.append(slot)
		slot.index = combo_slots.size() - 1
		slot.combo_bar_slot_changed.connect(_on_combo_bar_slot_changed)
	
func _on_combo_bar_slot_changed(slot_index:int, new_ca:Combo_Action_Resource):
	combo_bar_array[slot_index] = new_ca
	combo_bar_changed.emit(combo_bar_array)
	
func force_combo_bar_update(new_combo_array:Array[Combo_Action_Resource]):
	combo_bar_array = new_combo_array
	var i:int = 0
	for slot:Combo_Bar_Slot in $VBoxContainer.get_children():
		slot.combo_action_resource = new_combo_array[i]
		i += 1

func combo_action_being_executed(index:int):
	for slot in combo_slots:
		slot.reset_slot_color()
		
	combo_slots[index].slot_being_executed()
	

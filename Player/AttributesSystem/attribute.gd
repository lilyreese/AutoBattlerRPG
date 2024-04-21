class_name Attribute

signal attribute_modified()

var base_value:int = 0
var final_value:int = 0
var modifiers:Dictionary = {} #id, value

func _init():
	final_value = base_value
	
func add_modifier(id, value):
	modifiers[id] = value
	attribute_modified.emit()
	
func remove_modifier(id):
	if modifiers.has(id):
		modifiers.erase(id)
		attribute_modified.emit()
		
func _recalculate_final_value():
	var calculated_value:int = base_value
	for modifier in modifiers:
		calculated_value += modifier
		
	final_value = calculated_value
	
func get_final_value() -> int:
	_recalculate_final_value()
	return final_value
	
func change_base_value(value:int):
	base_value += value
	attribute_modified.emit()

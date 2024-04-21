class_name Attribute

signal attribute_modified(attribute:Attribute)

var key:String = ''
var base_value:int = 10 : set=_on_base_value_changed
var final_value:int = 0 : set=_on_final_value_changed
var modifiers:Dictionary = {} : set=_on_modifiers_changed

func _on_base_value_changed(value:int):
	var old_value = base_value
	base_value = value
	if old_value != value:
		_recalculate_final_value()
		
func _on_final_value_changed(value:int):
	var old_value = final_value
	final_value = value
	if old_value != value:
		_emit_change()

func _on_modifiers_changed(value):
	modifiers = value
	
func _init():
	final_value = base_value
	
func add_modifier(id, value):
	modifiers[id] = value
	
func remove_modifier(id):
	if modifiers.has(id):
		modifiers.erase(id)
		
func _recalculate_final_value():
	var calculated_value:int = base_value
	for modifier in modifiers:
		calculated_value += modifier
		
	final_value = calculated_value
	
func get_final_value() -> int:
	_recalculate_final_value()
	return final_value
	
func add_base_value(value:int):
	base_value += value

func _emit_change():
	attribute_modified.emit(self)

class_name Attribute_Menager extends Node

signal attribute_changed(attribute_key:Dictionary)
signal attribute_available_point_changed(value:int)

var attributes:Dictionary ={
	GlobalInfo.STRENGTH:null
	,GlobalInfo.AGILITY:null
	,GlobalInfo.DEXTERITY:null
}

var available_points:int = 10 : set=_set_available_points

# Called when the node enters the scene tree for the first time.
func _ready():
	for attribute in attributes.keys():
		var new_attribute:Attribute = Attribute.new()
		new_attribute.key = attribute
		attributes[attribute] = new_attribute
		new_attribute.attribute_modified.connect(_on_attribute_modified)
		
func add_attribute_base_value(attribute_key:String, value:int):
	if attributes.has(attribute_key) && available_points > 0:
		available_points -= 1
		
		var attribute:Attribute = attributes[attribute_key]
		attribute.add_base_value(value)
	
func get_attribute_final_value(attribute_key:String) -> int:
	var attribute:Attribute = attributes[attribute_key]
	return attribute.get_final_value()
	
func _on_attribute_modified(attribute:Attribute):
	attribute_changed.emit(attributes)
	
func _set_available_points(value:int):
	available_points = value
	attribute_available_point_changed.emit(available_points)
	

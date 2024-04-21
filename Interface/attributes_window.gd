class_name Attributes_Window extends Window

signal attribute_value_added(attribute_key:String)

@onready var attribute_plus_str:Button = $VBoxContainer/Attribute_Spliter/AttributePlusSTR
@onready var attribute_plus_agi:Button = $VBoxContainer/Attribute_Spliter4/AttributePlusAGI
@onready var attribute_plus_dex:Button = $VBoxContainer/Attribute_Spliter5/AttributePlusDEX

@onready var attribute_value_str:Label = $VBoxContainer/Attribute_Spliter/AttributeValueSTR
@onready var attribute_value_agi:Label = $VBoxContainer/Attribute_Spliter4/AttributeValueAGI
@onready var attribute_value_dex:Label = $VBoxContainer/Attribute_Spliter5/AttributeValueDEX

@onready var points_value:Label = $VBoxContainer/PointsAvailable/PointsValue

var button_controls:Dictionary = {}
var label_controls:Dictionary = {}

func _ready():
	button_controls[GlobalInfo.STRENGTH] = attribute_plus_str
	button_controls[GlobalInfo.AGILITY] = attribute_plus_agi
	button_controls[GlobalInfo.DEXTERITY] = attribute_plus_dex
	
	label_controls[GlobalInfo.STRENGTH] = attribute_value_str
	label_controls[GlobalInfo.AGILITY] = attribute_value_agi
	label_controls[GlobalInfo.DEXTERITY] = attribute_value_dex
	
	attribute_plus_str.button_up.connect(_on_attribute_button_pressed.bind(GlobalInfo.STRENGTH))
	attribute_plus_agi.button_up.connect(_on_attribute_button_pressed.bind(GlobalInfo.AGILITY))
	attribute_plus_dex.button_up.connect(_on_attribute_button_pressed.bind(GlobalInfo.DEXTERITY))
	
func _on_close_requested():
	self.visible = !self.visible
	
func _on_attribute_button_pressed(attribute_key:String):
	attribute_value_added.emit(attribute_key)

func update_attribute_base_values(attributes:Dictionary):
	for attribute in attributes.keys():
		var label:Label = label_controls[attribute]
		label.text = str(attributes[attribute].base_value)
		
func update_available_points(value:int):
	points_value.text = str(value)

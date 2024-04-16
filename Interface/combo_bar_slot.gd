class_name Combo_Bar_Slot extends TextureRect

@onready var color_rect:ColorRect = $ColorRect

@export_color_no_alpha var selected_color:Color

signal combo_bar_slot_changed(ca_resource:Combo_Action_Resource)

var combo_action_resource:Combo_Action_Resource : set = _set_combo_action_resource
var index:int = 0

var original_color:Color


func _ready():
	original_color = color_rect.color

func _get_drag_data(at_position):
	if !combo_action_resource:
		return
		
	set_drag_preview(_get_combo_action_icon())
	
	return _get_combo_action_drop_data()

func _get_combo_action_drop_data() -> Combo_Action_Drop_Data:
	var combo_action_drop_data:Combo_Action_Drop_Data = Combo_Action_Drop_Data.new()
	combo_action_drop_data.combo_action_resource = combo_action_resource
	combo_action_drop_data.origin_control = self
	return combo_action_drop_data
	
func _get_combo_action_icon():
	var icon = TextureRect.new()
	icon.size = Vector2(130,130)
	icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	icon.texture = combo_action_resource.action_icon
	icon.z_index = 10
	icon.top_level = true
	return icon

func _can_drop_data(position, data):
	if data is Combo_Action_Drop_Data:
		return true
		
	return false

func _drop_data(position, data):
	if data is Combo_Action_Drop_Data:
		if data.origin_control is Combo_Bar_Slot:
			data.origin_control.combo_action_resource = combo_action_resource
		
		combo_action_resource = data.combo_action_resource		

func _set_combo_action_resource(value:Combo_Action_Resource):
	combo_action_resource = value
	texture = combo_action_resource.action_icon
	combo_bar_slot_changed.emit(index, combo_action_resource)

func slot_being_executed():
	color_rect.color = selected_color

func reset_slot_color():
	color_rect.color = original_color

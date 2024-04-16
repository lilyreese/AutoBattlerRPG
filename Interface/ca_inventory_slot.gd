class_name CA_Inventory_Slot extends TextureRect

var combo_action_resource:Combo_Action_Resource

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

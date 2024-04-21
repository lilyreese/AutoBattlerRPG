class_name Player_Menager extends Node2D

@onready var attributes_window:Attributes_Window = $AttributesWindow
@onready var skill_inventory_canvas:CanvasLayer = $SkillInventoryCanvas
@onready var exp_hud:EXP_Hud = $EXPHud/EXPHud
@onready var combo_bar:Combo_Bar = $ComboBar/ComboBar

@onready var attribute_menager:Attribute_Menager = $AttributeMenager

@onready var combo_timer:Timer = $ComboTimer
@onready var combo_action_container:Node2D = $ComboActionContainer



@export var available_combo_action_array:Array[Combo_Action_Resource] = []
@export var combo_action_array:Array[Combo_Action_Resource] = []

var current_action_index:int = 0
var current_combo_action:Array[Combo_Action_Resource] = []

var current_level:int = 1
var current_exp:int = 0
var exp_to_level_up:int = 10
var exp_growth_ratio:float = 0.5

func _ready():
	WaveMenager.enemy_defeated.connect(_gain_exp)
	combo_timer.timeout.connect(_on_attack_timer_timeout)
	combo_bar.force_combo_bar_update(combo_action_array)
	combo_bar.combo_bar_changed.connect(_on_combo_bar_changed)
	
	attributes_window.attribute_value_added.connect(_on_attributes_window_attribute_value_added)
	
	attribute_menager.attribute_changed.connect(_on_attribute_changed)
	attribute_menager.attribute_available_point_changed.connect(_on_attribute_available_point_changed)
	
	attributes_window.update_attribute_base_values(attribute_menager.attributes)
	attributes_window.update_available_points(attribute_menager.available_points)
	
func _input(event):
	if Input.is_action_just_pressed("open_skill_inventory"):
		skill_inventory_canvas.visible = !skill_inventory_canvas.visible
		
	if Input.is_action_just_pressed("open_attribute_window"):
		attributes_window.visible = !attributes_window.visible

func _on_attack_timer_timeout():
	_execute_next_action()
	
func _execute_next_action():
	if combo_action_array.size() == 0:
		return
		
	if current_action_index > combo_action_array.size() - 1:
		current_action_index = 0
		current_combo_action.clear()
	
	if !combo_action_array[current_action_index]:
		return
	
	_instantiate_action_scene()
	_update_combo_timer()
	
	combo_bar.combo_action_being_executed(current_action_index)
	
	current_combo_action.append(combo_action_array[current_action_index])
	current_action_index += 1

func _instantiate_action_scene():
	var current_action_scene:Base_Combo_Action = combo_action_array[current_action_index].combo_scene.instantiate() as Base_Combo_Action
	current_action_scene.set_action_damage(combo_action_array[current_action_index].base_damage + attribute_menager.get_attribute_final_value(GlobalInfo.STRENGTH))
	combo_action_container.add_child(current_action_scene)

func _update_combo_timer():
	combo_timer.wait_time = combo_action_array[current_action_index].base_duration
	combo_timer.start()
	
func _on_combo_bar_changed(ca_array:Array[Combo_Action_Resource]):
	combo_action_array = ca_array

func _gain_exp(value):
	current_exp += value
	if current_exp >= exp_to_level_up:
		current_level += 1
		attribute_menager.available_points += 1
		current_exp = current_exp - exp_to_level_up
		exp_to_level_up += int(exp_to_level_up * exp_growth_ratio)
		
	exp_hud.update_values(current_level, current_exp, exp_to_level_up)
	
func _on_attributes_window_attribute_value_added(attribute_key:String):
	attribute_menager.add_attribute_base_value(attribute_key, 1)
	
func _on_attribute_changed(attributes:Dictionary):
	attributes_window.update_attribute_base_values(attributes)

func _on_attribute_available_point_changed(value:int):
	attributes_window.update_available_points(value)

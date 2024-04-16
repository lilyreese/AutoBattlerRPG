class_name EXP_Hud extends Control

@onready var level:Label = $VBoxContainer/Level
@onready var exp:Label = $VBoxContainer/EXP

func update_values(_level:int, _exp:int, _exp_to_level_up:int):
	level.text = str("Level: ", _level)
	exp.text = str("Exp: ", _exp, " / ", _exp_to_level_up)

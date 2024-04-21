class_name Global_Info extends Node

const STRENGTH = 'Strength'
const AGILITY = 'Agility'
const DEXTERITY = 'Dexterity'

func _input(event):
	if Input.is_action_just_pressed("exit_game"):
		get_tree().quit()
		


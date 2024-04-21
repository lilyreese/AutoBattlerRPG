class_name Global_Commands extends Node


func _input(event):
	if Input.is_action_just_pressed("exit_game"):
		get_tree().quit()

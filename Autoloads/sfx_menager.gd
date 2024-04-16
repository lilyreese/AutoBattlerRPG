class_name SFX_Menager extends Node

func play_sfx_at_position(sfx:AudioStream, pos:Vector2):
	var sfx_node:AudioStreamPlayer2D = AudioStreamPlayer2D.new()
	sfx_node.stream = sfx
	sfx_node.global_position = pos
	add_child(sfx_node)
	sfx_node.finished.connect(func():sfx_node.queue_free())
	sfx_node.play()
	

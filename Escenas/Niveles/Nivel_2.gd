extends Node2D



func _on_nivel_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene_to_file("res://Escenas/Niveles/Nivel_3.tscn")
	pass # Replace with function body.

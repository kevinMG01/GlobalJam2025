extends Node2D


var boton = 0



func _on_salir_pressed():
	boton = 2
	$explocion.play()
	$tiempoSonido.start()
	$salir.queue_free()

func _on_play_pressed():
	boton = 1
	$explocion.play()
	$tiempoSonido.start()
	$Play.queue_free()





func _on_tiempo_sonido_timeout():
	if boton == 1:
		get_tree().change_scene_to_file("res://Escenas/Niveles/nivel_1.tscn")
	elif boton == 2:
		get_tree().quit()
	$tiempoSonido.stop()

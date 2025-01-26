extends Node2D


var boton = 0

func _ready():
	if GlobalVar.inicio == 1:
		$eleccion.visible = false


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


func _on_mas_button_down():
	GlobalVar.personaje = false
	GlobalVar.inicio = 1
	$eleccion.visible = false


func _on_fem_button_down():
	GlobalVar.personaje = true
	GlobalVar.inicio = 1
	$eleccion.visible = false

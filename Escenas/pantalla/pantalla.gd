extends CanvasLayer



func _process(delta):
	
	$textVida.text = "Vida: " + str(GlobalVar.vidasJugador)

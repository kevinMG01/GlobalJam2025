extends CharacterBody2D

const gravedad = 20.0

func _ready():
	velocity.y = gravedad




func _process(delta):
	velocity.y += gravedad
	move_and_slide()






func _on_detector_body_entered(body):
	if body.is_in_group("player"):
		GlobalVar.vidasJugador -= 1



func _on_timer_timeout():
	queue_free()


extends CharacterBody2D


const SPEED = 400.0

var enredaderas = 2
var bajarSubir = "bajar"

func _physics_process(delta):

	var direction
	if bajarSubir == "bajar":
		direction = 1
	elif bajarSubir == "subir":
		direction =-1
	

	if direction:
		velocity.y = direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()


func _on_detector_body_entered(body):
	bajarSubir = "quieto"
	$lanzarEnredaderas.start()


func _on_lanzar_enredaderas_timeout():
	enredaderas -= 1
	if enredaderas == 0:
		bajarSubir = "subir"
		$lanzarEnredaderas.stop()


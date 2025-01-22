extends CharacterBody2D

var enredar = preload("res://Escenas/Enemigos/spider/enredaderas/enredaderas.tscn")

const SPEED = 400.0

var enredaderas = 2
var bajarSubir = "bajar"

var player = null

func _physics_process(delta):

	var direction
	if bajarSubir == "bajar":
		direction = 1
	elif bajarSubir == "subir":
		direction =-1
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	if direction:
		velocity.y = direction * SPEED

	move_and_slide()

func spawnENREDADERAS():
	var newenredaderas = enredar.instantiate()
	newenredaderas.direccion = player.global_position - $posEnredadera.global_position
	#newenredaderas.rotation_degrees = $pos_bala.rotation_degrees
	newenredaderas.global_position = $posEnredadera.global_position
	get_parent().add_child(newenredaderas)

func _on_detector_body_entered(body):
	if body.is_in_group("player"):
		bajarSubir = "quieto"
		return

	bajarSubir = "quieto"
	$lanzarEnredaderas.start()


func _on_lanzar_enredaderas_timeout():
	if enredaderas == 0:
		bajarSubir = "subir"
		$lanzarEnredaderas.stop()
		return
	spawnENREDADERAS()
	enredaderas -= 1



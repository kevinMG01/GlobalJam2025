extends CharacterBody2D

var enredar = preload("res://Escenas/Enemigos/spider/enredaderas/enredaderas.tscn")

const SPEED = 400.0

@onready var raycast: RayCast2D = $detectorTechos
var enredaderas = 2
var bajarSubir = "subir"

var raycastActivado = false
var player = null
var tiempoTecho = 3


func _physics_process(delta):
	if raycast.is_colliding() and raycastActivado == false:
		var collider = raycast.get_collider()
		bajarSubir = "quieto"
		$tiTecho.wait_time = tiempoTecho
		$tiTecho.start()
		raycastActivado = true
	
	if not raycast.is_colliding() and raycastActivado == true:
		raycastActivado = false

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
	#si la araña care por encima del player
	if body.is_in_group("player"):
		bajarSubir = "quieto"
		return

	bajarSubir = "quieto"
	$lanzarEnredaderas.start()


func _on_lanzar_enredaderas_timeout():
	if player != null:
		if enredaderas == 0:
			bajarSubir = "subir"
			$lanzarEnredaderas.stop()
			return
		spawnENREDADERAS()
		enredaderas -= 1
	else:
		bajarSubir = "subir"


func _on_radar_body_entered(body):
	if body.is_in_group("player"):
		player = body


func _on_radar_body_exited(body):
	if body.is_in_group("player"):
		player = null


func _on_ti_techo_timeout():
	bajarSubir = "bajar"
	$tiTecho.stop()


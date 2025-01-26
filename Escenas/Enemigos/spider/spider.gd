extends CharacterBody2D

var enredar = preload("res://Escenas/Enemigos/spider/enredaderas/enredaderas.tscn")

const SPEED = 400.0

@onready var raycast: RayCast2D = $detectorTechos
var enredaderas = 2
var bajarSubir = "subir"

var raycastActivado = false
var player = null
var tiempoTecho = 5


var tiempoLanzadorEnredaderas = 3

func _physics_process(delta):
	if raycast.is_colliding() and raycastActivado == false:
		var collider = raycast.get_collider()
		bajarSubir = "quieto"
		$caminar.stop()
		$tiTecho.wait_time = tiempoTecho
		$tiTecho.start()
		enredaderas = 2
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
		$caminar.stop()

	if direction:
		velocity.y = direction * SPEED

	move_and_slide()


func spawnENREDADERAS():
	var newenredaderas = enredar.instantiate()
	newenredaderas.direccion = player.global_position - $posEnredadera.global_position
	newenredaderas.rotation_degrees = (player.position - $posEnredadera.position).angle()
	newenredaderas.global_position = $posEnredadera.global_position
	get_parent().add_child(newenredaderas)

func _on_detector_body_entered(body):
	#si la araña care por encima del player
	if body.is_in_group("player"):
		bajarSubir = "quieto"
		$caminar.stop()
		GlobalVar.vidasJugador -= 1
		$subir.wait_time = 1
		$subir.start()
		return

	$caminar.stop()
	bajarSubir = "quieto"
	$lanzarEnredaderas.wait_time = tiempoLanzadorEnredaderas
	$lanzarEnredaderas.start()


func _on_lanzar_enredaderas_timeout():
	if player != null:
		if enredaderas == 0:
			bajarSubir = "subir"
			$caminar.play()
			$lanzarEnredaderas.stop()
			return
		spawnENREDADERAS()
		$disparar.play()
		enredaderas -= 1
	else:
		bajarSubir = "subir"
		$caminar.play()


func _on_radar_body_entered(body):
	if body.is_in_group("player"):
		player = body


func _on_radar_body_exited(body):
	if body.is_in_group("player"):
		player = null


func _on_ti_techo_timeout():
	bajarSubir = "bajar"
	$caminar.play()
	$tiTecho.stop()



func _on_subir_timeout():
	bajarSubir = "subir"
	$caminar.play()
	$subir.stop()
	pass # Replace with function body.

extends CharacterBody2D

var objeto = preload("res://Escenas/Enemigos/murcielago/cuchillo/cuchillo.tscn")   #colocar la ruta del objeto

var speed = 900.0
var SPEED = 200.0

var player = null

var lanzarObjeto = false

func _ready():
	$AnimatedSprite2D.play()
	velocity.x = -SPEED
	$move.play()

func _next_to_left_Wall() -> bool:
	return $Leftray.is_colliding()
	
func _next_to_right_Wall() -> bool:
	return $Rightray.is_colliding()


func _flip():
	if player == null:
		if _next_to_left_Wall() or _next_to_right_Wall():
			velocity.x *= -1
			$AnimatedSprite2D.scale.x *= -1

func _physics_process(delta):
	_flip()
	follow()
	move_and_slide()

func follow():
	if player != null:
		# Calculamos la dirección hacia el jugador (diferencia entre posiciones)
		var direction = player.global_position - global_position
		
		# Verificamos la distancia en el eje X
		if abs(direction.x) > 6:  # Si la distancia en X es mayor a 6 unidades
			velocity.x = sign(direction.x) * SPEED  # Movemos en la dirección del jugador (sin normalizar)
		else:
			velocity.x = 0  # Si está cerca en X, detenemos el movimiento
			if lanzarObjeto == false:
				$Timer.start()
				$tirar.play()
				lanzarObjeto = true


func spawnObjetos():
	var newObjeto = objeto.instantiate()
	#newObjeto.direccion = Vector2(1,0)
	newObjeto.global_position = $poscuchillo.global_position
	get_parent().add_child(newObjeto)
	


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player = body
	pass


func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		player = null



func _on_timer_timeout():
	spawnObjetos()
	lanzarObjeto = false
	$Timer.stop()



func _on_detector_area_entered(area):
	if area.is_in_group("burbuja"):
		speed = 0
		SPEED = 0
		$Timer2.start(5)



func _on_timer_2_timeout():
	speed = 900.0
	SPEED = 200.0
	$Timer2.stop()
	pass # Replace with function body.

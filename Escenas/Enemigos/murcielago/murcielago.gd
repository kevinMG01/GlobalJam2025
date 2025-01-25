extends CharacterBody2D

var objeto = preload("res://Escenas/Enemigos/murcielago/cuchillo/cuchillo.tscn")   #colocar la ruta del objeto

const speed = 900.0
const SPEED = 200.0

var player = null
# Get the gravity from the project settings to be synced with RigidBody nodes.

var lanzarObjeto = false

func _ready():
	velocity.x = -SPEED

func _next_to_left_Wall() -> bool:
	return $Leftray.is_colliding()
	
func _next_to_right_Wall() -> bool:
	return $Rightray.is_colliding()


func _flip():
	if _next_to_left_Wall() or _next_to_right_Wall():
		velocity.x *= -1
		$Sprite2D.scale.x *= -1

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
				lanzarObjeto = true


func spawnObjetos():
	var newObjeto = objeto.instantiate()
	#newObjeto.direccion = Vector2(1,0)
	newObjeto.global_position = $poscuchillo.global_position
	get_parent().add_child(newObjeto)
	
	pass

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player = body
	pass


func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		player = null



func _on_timer_timeout():
	spawnObjetos()
	$Timer.stop()
	lanzarObjeto = false

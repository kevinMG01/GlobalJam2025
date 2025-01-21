extends CharacterBody2D


var burbujas = preload("res://Escenas/Player/burbujas/burbujas.tscn")

const SPEED = 300.0
const JUMP_VELOCITY = -1300.0

var gravity = 2000

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		spawnBurbujas()

	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		cambiarDireccion(direction)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func cambiarDireccion(direccion):
	if direccion == 1:#derecha
		$posBurbujas.position = Vector2(85,0)
	if direccion == -1:
		$posBurbujas.position = Vector2(-85,0)


func spawnBurbujas():
	var newBurbujas = burbujas.instantiate()
	newBurbujas.direccion = Vector2(1,0)
	newBurbujas.global_position = $posBurbujas.global_position
	get_parent().add_child(newBurbujas)






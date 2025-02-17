extends CharacterBody2D


var burbujas = preload("res://Escenas/Player/burbujas/burbujas.tscn")

var SPEED = 300.0
const JUMP_VELOCITY = -1000.0

var gravity = 2500

var cantidadBurbujas = 20

var colliding_ladder = false
var going_up = false
var acceleration = 100
var max_speed = 200

var enredadera = false


func _ready():
	if GlobalVar.personaje == false:
		$AnimatedSprite2D.visible = false
		$maasculino.visible = true
	if GlobalVar.personaje == true:
		$AnimatedSprite2D.visible = true
		$maasculino.visible = false
	$AnimatedSprite2D.play()
	$maasculino.play()

func _physics_process(delta):
	if GlobalVar.vidasJugador <= 0:
		queue_free()
	if Input.is_action_just_pressed("UI_s"):
		if cantidadBurbujas > 0:
			spawnBurbujas()
			cantidadBurbujas -= 1

	if !going_up:
		if not is_on_floor():
			velocity.y += gravity * delta
			$AnimatedSprite2D.animation = "caida"
			$maasculino.animation = "caida"
			

	climb()
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D.animation = "salto"
		

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		cambiarDireccion(direction)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			$maasculino.animation = "normal"
			$AnimatedSprite2D.animation = "normal"
	
	if enredadera == true:
		if is_on_floor():
			gravity = 10000
		if not is_on_floor():
			gravity = 100

	move_and_slide()


func cambiarDireccion(direccion):
	if direccion == 1:#derecha
		$posBurbujas.position = Vector2(85,0)
		if is_on_floor():
			$AnimatedSprite2D.animation = "correr"
			$maasculino.animation = "correr"
		$AnimatedSprite2D.flip_h = false
		$maasculino.flip_h = false
	if direccion == -1:
		if is_on_floor():
			$AnimatedSprite2D.animation = "correr"
			$maasculino.animation = "correr"
		$maasculino.flip_h = true
		$AnimatedSprite2D.flip_h = true
		$posBurbujas.position = Vector2(-85,0)


func spawnBurbujas():
	var newBurbujas = burbujas.instantiate()
	if $AnimatedSprite2D.flip_h == false:
		newBurbujas.direccion = Vector2(1,0)
	if $AnimatedSprite2D.flip_h == true:
		newBurbujas.direccion = Vector2(-1,0)
	newBurbujas.global_position = $posBurbujas.global_position
	
	get_parent().add_child(newBurbujas)



func subirEscaleras():
	
	
	pass


func climb():
	if colliding_ladder:
		if Input.is_action_pressed("ui_up"):
			going_up = true
			velocity.y = max(velocity.y - acceleration, -max_speed)
		elif Input.is_action_pressed("ui_down"):
			going_up = true
			velocity.y = min(velocity.y + acceleration, max_speed)
		else:
			if going_up:
				velocity.y = 0

func _on_detector_escaleras_area_entered(area):
	area.get_name()
	if area.is_in_group("escalera"):
		colliding_ladder = true


func _on_detector_escaleras_area_exited(area):
	area.get_name()
	if area.is_in_group("escalera"):
		colliding_ladder = false
		going_up = false


func _on_detectar_area_entered(area):
	if area.is_in_group("enredadera"):
		SPEED = 60.0

		enredadera = true


func _on_detectar_area_exited(area):
	if area.is_in_group("enredadera"):
		SPEED = 300.0
		gravity = 2000
		enredadera = false







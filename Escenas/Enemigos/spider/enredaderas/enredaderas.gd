extends CharacterBody2D

var direccion :Vector2
@export var velocidad:int


func _ready():
	randomize()
	var tip = randf_range(1.2, 2.7)
	$tiempoMov.wait_time = tip
	$tiempoMov.start()

func _physics_process(delta):
	velocity = direccion.normalized() * velocidad
	move_and_slide()

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


func _on_tiempo_mov_timeout():
	direccion = Vector2(0,-1)
	velocidad = 100
	var t = randf_range(1.3, 2.7)
	$destuccion.wait_time = t
	$destuccion.start()
	$tiempoMov.stop()




func _on_destuccion_timeout():
	queue_free()
	$destuccion.stop()


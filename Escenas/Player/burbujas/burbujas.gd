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
	$AnimatedSprite2D.animation = "explocion"
	$AnimatedSprite2D.play()
	$Timer.start(0.6)
	$destuccion.stop()



func _on_detener_sonido_timeout():
	$burbuja.queue_free()



func _on_timer_timeout():
	queue_free()
	pass # Replace with function body.

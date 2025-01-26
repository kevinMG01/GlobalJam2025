extends CharacterBody2D





var direccion :Vector2
@export var velocidad:int





func _physics_process(delta):
	velocity = direccion.normalized() * velocidad
	move_and_slide()


func _on_detector_body_entered(body):
	direccion = Vector2(0, 0)
	







func _on_timer_timeout():
	queue_free()


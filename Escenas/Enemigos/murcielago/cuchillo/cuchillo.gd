extends CharacterBody2D

const gravedad = 20.0
# Called when the node enters the scene tree for the first time.
func _ready():
	velocity.y = gravedad
	eliminar()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.y += gravedad
	move_and_slide()
	pass
func eliminar():
	if velocity.y <= 1 :
		queue_free()
	pass

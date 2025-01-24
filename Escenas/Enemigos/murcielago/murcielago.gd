extends CharacterBody2D


const SPEED = 200.0

var player = null
# Get the gravity from the project settings to be synced with RigidBody nodes.

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
		if global_position.x > player.global_position.x + 6:
			velocity.x -= SPEED
		if global_position.x < player.global_position.x - 6:
			velocity.x += SPEED
	pass




func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player = body
	pass


func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		player = null
	pass # Replace with function body.

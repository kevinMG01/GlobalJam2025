extends CharacterBody2D

const  speed2 = 150.0
const SPEED = 5
const JUMP_VELOCITY = -400.0


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var player = null

func _ready():
	#player = get_tree().get_nodes_in_group("player")[0]
	velocity.x = SPEED
func _physics_process(delta):
	follow()
	if not is_on_floor():
		velocity.y += gravity * delta
	#var direction = 1
	if is_on_wall(): 
		if !$Sprite2D.flip_h:
			velocity.x = speed2
		else:
			velocity.x = -speed2
		#
		if velocity.x < 0:
			$Sprite2D.flip_h = false
			#direction = 1
		elif velocity.x > 0:
			$Sprite2D.flip_h = true 
			#direction = -1
	

	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	
	#if direction:
		#velocity.x = direction * SPEED
		#direccions(direction)
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func caminar():
	
	pass


func direccions(dir):
	if dir == 1:
		$Area2D/CollisionShape2D.position = Vector2(256, 26)
	elif dir == -1: 
		$Area2D/CollisionShape2D.position =  Vector2(-256, 26)
	pass

func follow():
	if player != null:
		
		if global_position.x > player.global_position.x + 6:
			velocity.x -= SPEED
		if global_position.x < player.global_position.x - 6:
			velocity.x += SPEED
		




func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player = body



func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		player = null
	pass # Replace with function body.

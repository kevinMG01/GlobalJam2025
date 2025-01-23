extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -400.0
#var player = null

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _ready():
	#player = get_tree().get_nodes_in_group("player")[0]
	velocity.x = SPEED
func _physics_process(delta):
	#follow()
	if not is_on_floor():
		velocity.y += gravity * delta
	if is_on_wall():
		if !$Sprite2D.flip_h:
			velocity.x = SPEED
		else:
			velocity.x = -SPEED
		
		if velocity.x < 0:
			$Sprite2D.flip_h = false
		elif velocity.x > 0:
			$Sprite2D.flip_h = true 
	

	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


#func follow():
	#if player != null:
		#velocity = position.direction_to(player.position) * SPEED
		#
		#move_and_slide()



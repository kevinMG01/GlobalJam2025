extends CharacterBody2D

var  speed2 = 150.0
var SPEED = 5
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
			$AnimatedSprite2D.flip_h = false
			#direction = 1
		elif velocity.x > 0:
			$AnimatedSprite2D.flip_h = true 
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
			$AnimatedSprite2D.flip_h = false
		if global_position.x < player.global_position.x - 6:
			velocity.x += SPEED
			$AnimatedSprite2D.flip_h = true 
		




func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player = body



func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		player = null



func _on_detectar_area_entered(area):
	if area.is_in_group("burbuja"):
		speed2 = 0
		SPEED = 0
		$Timer.start()



func _on_timer_timeout():
	speed2 = 150.0
	SPEED = 5
	$Timer.stop()



extends CharacterBody2D

var direccion :Vector2
@export var velocidad:int


func _ready():
	pass



func _physics_process(delta):
	velocity = direccion.normalized() * velocidad
	move_and_slide()

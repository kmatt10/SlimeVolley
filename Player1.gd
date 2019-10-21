extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal game_start

export var MOVE_SPEED = 250
export var JUMP_HEIGHT = 350
const GRAVITY = 500
var velocity = Vector2()
var on_ground = false

func _ready():
	on_ground = false

func _physics_process(delta):
	if not on_ground:
		velocity.y += delta * GRAVITY
	else:
		velocity.y = 0
	
	if(get_parent().State == 1): #game is active
		if Input.is_action_pressed("ui_left"):
			velocity.x = -MOVE_SPEED
		elif Input.is_action_pressed("ui_right"):
			velocity.x = MOVE_SPEED
		else:
			velocity.x = 0
			
		if Input.is_action_pressed("ui_up") and on_ground:
			velocity.y = -JUMP_HEIGHT
	elif get_parent().State == 0: #game is ready to start again
		if Input.is_action_just_pressed("ui_accept"):
			emit_signal("game_start")
	else: #game is inbetween states
		pass
	move_and_slide(velocity,Vector2(0,-1))
	on_ground = is_on_floor()
	
func stop():
	velocity = Vector2()
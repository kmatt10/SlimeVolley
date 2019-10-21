extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
enum gamestate {inactive, active, transition}
onready var State = gamestate.inactive

var player=null
var ball=null
onready var startpos = $StartingPoint.position
var updatedspeed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.score1 = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func end_game():
	$Player1Root.stop()
	State = gamestate.transition
	$HUD.game_over()
	yield($HUD/msg_time, "timeout")
	State = gamestate.inactive


func _on_BallArea_body_entered(body):
	if State == gamestate.active:
		if(body.get_collision_layer_bit(1)):
			end_game()

func _on_BallRoot_body_entered(body):
	if(body.get_collision_layer_bit(0)):
		if State == gamestate.active:
			$HUD.score()
			updatedspeed = true
			if ((Globals.score1%4) == 0 && updatedspeed):
				updatedspeed = false
				$BallRoot.BOUNCE_SPEED*=2
				$HUD.show_message("Bouncy!")
		var b = $Player1Root.position.x
		var a = $Player1Root.position.y
		$BallRoot.bump(b,a)
		#$HUD.score()

func _on_Player1Root_game_start():
	$Player1Root.position = $playerstart.position
	$HUD.game_start()
	yield($HUD/msg_time,"timeout")
	$BallRoot.position = startpos
	$BallRoot.position.x = $playerstart.position.x + 150
	$BallRoot.start()
	print($BallRoot.BOUNCE_SPEED)
	State = gamestate.active
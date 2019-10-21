extends RigidBody2D

signal out_of_bounds

export var SERVE_SPEED = 250
var LEFT_SIDE = false
export var BOUNCE_SPEED = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	BOUNCE_SPEED = 10
	var dir = pow(-1,randi()%2)
	apply_impulse(Vector2(),Vector2(1,1).normalized() *dir * SERVE_SPEED)

func start():
	BOUNCE_SPEED = 10
	var dir = pow(-1,randi()%2)
	#apply_impulse(Vector2(),Vector2(self.position.x,self.position.y).normalized() *dir * SERVE_SPEED)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Player2Area_area_entered(area):
	LEFT_SIDE = false

func _on_Player1Area_area_entered(area):
	LEFT_SIDE = true

func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("out_of_bounds")

func bump(x,y):
	var a = self.position.x - x
	var b = self.position.y - y
	apply_impulse(Vector2(),Vector2(a,b).normalized()*BOUNCE_SPEED)
extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$startbutton.show()
	$scorelabel.set_text("Score: 0")
	$scorelabel.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func show_message(text):
	$messagelabel.text = text
	$messagelabel.show()
	if get_parent().State == 1:
		yield(get_tree().create_timer(1), 'timeout')
		$messagelabel.hide()
	else:
		$msg_time.start()
	
func game_start():
	$startbutton.hide()
	$"/root/Globals".score1 = 0
	$scorelabel.set_text("Score: " + str($"/root/Globals".score1))
	$scorelabel.show()
	show_message("Get ready!")
	yield($msg_time, "timeout")
	$messagelabel.hide()

func game_over():
	show_message("Game Over!")
	yield($msg_time, "timeout")
	$messagelabel.text = "Try again!"
	$messagelabel.show()
	yield(get_tree().create_timer(2),'timeout')
	$startbutton.show()
	
func score():
	$"/root/Globals".score1 += 1
	$scorelabel.set_text("Score: " + str($"/root/Globals".score1))
extends CanvasLayer

const READ_SPEED = 0.05


@onready var start = $Text/Start
@onready var text = $Text/Text
@onready var cont = $Text/Continue
@onready var box = $Text
@onready var player = $"Text/Player talk"
@onready var enemy = $"Text/Enemy talk"
@onready var animation = $AnimationPlayer

var start_game = false

enum State {
	READY = 0,
	READING = 1,
	FINISHED = 2
}

enum speaker {
	PLAYER = 0,
	ENEMY = 1
}

var current_state = State.READY
var skip = false
var msgbuffer = Array()
var chabuffer = Array()

###########
#FUNCTIONS#
###########

func _ready():
	current_state = State.READY
	hide_textbox()
func _process(delta):
	match current_state:
		State.READY:
			pass
		State.READING:
			if Input.is_action_just_pressed("ui_accept"):
				skip = true
		State.FINISHED:
			if Input.is_action_just_pressed("ui_accept"):
				hide_textbox()
				change_state(State.READY)
				if msgbuffer.is_empty():
					slow_disappear()
				else:
					var msg = msgbuffer.pop_front()
					var cha = chabuffer.pop_front()
					add_text(msg,cha)
	if cont.text == "v":
		if Engine.get_frames_drawn() % 60 > 30:
			cont.visible = true
		else:
			cont.visible = false
func hide_textbox():
	start.text = ""
	cont.text = ""
	text.text = ""
	player.visible = false
	enemy.visible = false
	box.hide()

func show_textbox():
	start.text = "*"
	box.show()
	for i in range(text.get_total_character_count()+1):
		$TextBeep.play()
		text.visible_characters = i
		if skip:
			text.visible_characters = -1
			break
		await get_tree().create_timer(0.02).timeout
	cont.text = "v"
	change_state(State.FINISHED)

func add_text(next_text, sender):
	if current_state != State.READY:
		msgbuffer.append(next_text)
		chabuffer.append(sender)
	else:
		text.text = next_text
		if sender == speaker.ENEMY:
			enemy.visible = true
		else:
			player.visible = true
		change_state(State.READING)
		text.visible_characters = 0
		show_textbox()
	
	
func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			pass
		State.READING:
			pass
		State.FINISHED:
			pass

func slow_disappear():
	animation.play("open_bars")
	get_tree().call_group("Start level","start_lvl")

func slow_appear():
	animation.play("close_bars")

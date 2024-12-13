extends Node2D

var rng = RandomNumberGenerator.new()
var attack = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	set_process(false)
func start_lvl():
	set_process(true)
func _process(delta):
	if attack == false:
		attack = true
		match int(rng.randf_range(0,2)):
			1:
				$main_events/events.play("mainAttack")
			2:
				$main_events/events.play("mainAttack")
			0:
				$main_events/events.play("mainAttack")
	await get_tree().create_timer(10).timeout

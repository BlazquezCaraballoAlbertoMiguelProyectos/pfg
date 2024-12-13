extends CharacterBody2D


func start_lvl():
	set_process(true)
	
func _process(delta):
	pass
	
	
#animation changes
func attack():
	$shout.play()
	$animation.play("swipe")
	await get_tree().create_timer(1).timeout
	$sword.play()
	await get_tree().create_timer(1).timeout
	$thump.play()
	
func  jump():
	$animation.play("jump")
	$hop.play()

func idle():
	$animation.play("idle")

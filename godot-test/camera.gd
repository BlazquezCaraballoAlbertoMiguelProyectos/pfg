extends Camera2D

@export var player: NodePath
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#Function to focus camera on player horizontally
	if player:
		var player_node = get_node(player)
		global_position.x = player_node.global_position.x + 100

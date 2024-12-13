extends CollisionShape2D

@export var sprite: NodePath
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	connect("area_endtered", self, "_on_area_entered")

extends ParallaxBackground


onready var parallax := $ParallaxLayer
onready var background := $ParallaxLayer/Sprite

var velocity := Vector2.ZERO
var gravity := 8.0
var distance := 2.0


func _ready() -> void:
	yield(get_parent(), "ready")
	background.set_texture(
		load(Data.back_dir + '/' + Data.background[UserData.last_background]))

func _physics_process(delta: float) -> void:
	velocity.y = clamp(velocity.y - gravity * delta, -800.0, 0)
	parallax.motion_offset.y += velocity.y * delta / distance

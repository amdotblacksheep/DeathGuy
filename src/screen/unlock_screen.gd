extends ConfirmationDialog


signal unlocked(index)


onready var label := $RichTextLabel
onready var button_sfx := $ButtonSFX
onready var error_sfx := $ErrorSFX
onready var tween := $Tween

var node : Node
var method : String
var index : int
var cost : int
var text := "You're in the mood for shopping... this requires %d coins. Do you want to buy it?"

func _ready() -> void:
	get_close_button().connect("pressed", self, "_on_UnlockScreen_cancelled")
	get_cancel().connect("pressed", self, "_on_UnlockScreen_cancelled")

func _on_unlock_pressed(
	new_node : Node, 
	new_method : String, 
	new_index : int, 
	new_cost : int
	) -> void:
	
	if node:
		disconnect("unlocked", node, method)
	
	connect("unlocked", new_node, new_method)
	
	node = new_node
	method = new_method
	index = new_index
	cost = new_cost
	label.set_bbcode(text % cost)
	label.set_percent_visible(0)
	
	popup()
	tween.interpolate_property(
		label, "percent_visible", 0, 1, 0.5, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func _on_UnlockScreen_confirmed() -> void:
	if UserData.wallet >= cost:
		emit_signal("unlocked", index)
		button_sfx.play()
	else:
		error_sfx.play()

func _on_UnlockScreen_cancelled() -> void:
	if not button_sfx.is_playing():
		button_sfx.play()

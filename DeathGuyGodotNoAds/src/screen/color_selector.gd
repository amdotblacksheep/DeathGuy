extends Control


signal show_unlock()
signal set_player_color(new_color)


onready var grid := $ColorGrid
onready var button_sfx := $ButtonSFX

var color : int = UserData.last_color
var cost := 250

func _ready() -> void:
	yield(get_parent(), "ready")
	connect("show_unlock", get_parent().unlock_screen, "_on_ShowUnlock")
	connect("set_player_color", get_parent().get_node("PlayerSelector"), "change_color")
	for switch in grid.get_children():
		if switch.get_index() in UserData.unlocked_color:
			switch.locked = false
		if UserData.last_color == switch.get_index():
			switch.set_pressed(true)
		if switch.locked:
			switch.connect("pressed", self, "_on_UnlockColor", [switch])
		else:
			switch.connect("pressed", self, "_on_ChangeColor", [switch.get_index()])

func _on_ChangeColor(new_color : int) -> void:
	button_sfx.play()
	for switch in grid.get_children():
		if switch.get_index() != new_color:
			switch.set_pressed(false)
	color = new_color
	UserData.last_color = color
	emit_signal("set_player_color", new_color)
	SaveLoad.save_game()

func _on_UnlockColor(switch : Button) -> void:
	button_sfx.play()
	switch.set_pressed(false)
	emit_signal("show_unlock", self, "_on_UnlockedColor", switch.get_index(), cost)

func _on_UnlockedColor(index : int) -> void:
	var switch := grid.get_child(index)
	switch.disconnect("pressed", self, "_on_UnlockColor")
	switch.connect("pressed", self, "_on_ChangeColor", [index])
	UserData.unlocked_color.append(index)
	switch.emit_signal("pressed")
	switch.set_pressed(true)
	UserData.wallet -= cost
	get_parent().coin.set_text(str(UserData.wallet))

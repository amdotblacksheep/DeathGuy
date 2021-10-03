extends Control


signal unlock_pressed()
signal player_color_changed(new_color)


onready var grid := $ColorGrid
onready var button_sfx := $ButtonSFX

var color : int = UserData.last_color
var cost := 250

func _ready() -> void:
	yield(owner, "ready")
	for switch in grid.get_children():
		if switch.get_index() in UserData.unlocked_color:
			switch.locked = false
		if UserData.last_color == switch.get_index():
			switch.set_pressed(true)
		if switch.locked:
			switch.connect(
				"pressed", self, "_on_Unlock_pressed", [switch])
		else:
			switch.connect(
				"pressed", self, "_on_Change_pressed", [switch.get_index()])

func _on_Change_pressed(new_color : int) -> void:
	button_sfx.play()
	
	for switch in grid.get_children():
		if switch.get_index() != new_color:
			switch.set_pressed(false)
	
	color = new_color
	UserData.last_color = color
	
	emit_signal("player_color_changed", new_color)
	
	SaveLoad.save_game()

func _on_Unlock_pressed(switch : Button) -> void:
	button_sfx.play()
	switch.set_pressed(false)
	
	emit_signal(
		"unlock_pressed", self, "_on_color_unlocked", 
		switch.get_index(), cost)

func _on_color_unlocked(index : int) -> void:
	var switch := grid.get_child(index)
	switch.disconnect("pressed", self, "_on_Unlock_pressed")
	switch.connect("pressed", self, "_on_Change_pressed", [index])
	switch.emit_signal("pressed")
	switch.set_pressed(true)
	
	UserData.unlocked_color.append(index)
	UserData.wallet -= cost
	
	get_parent().coin.set_text(str(UserData.wallet))
	
	SaveLoad.save_game()

extends CanvasLayer

signal closed()

onready var root_node := $Control
onready var label := $Control/CenterContainer/RichTextLabel
onready var banner := $Control/TextureRect
onready var progress := $Control/TextureProgress
onready var progress_text := $Control/TextureProgress/Label
onready var close_button := $Control/CloseButton
onready var timer := $Control/Timer

var type := 0


func _ready() -> void:
	randomize()
	type = randi() % Main.fake_ads_text.size()
	banner.set_texture(Main.fake_ads_img[type])
	label.set_bbcode(Main.fake_ads_text[type])

func _process(delta: float) -> void:
	progress.set_value(timer.time_left)
	progress_text.set_text(str(int(timer.time_left)))

func show_ads(time : int) -> void:
	root_node.set_visible(true)
	timer.set_wait_time(time)
	progress.max_value = time
	progress.set_value(timer.time_left)
	progress_text.set_text(str(int(timer.time_left)))
	timer.start()

func _on_UrlButton_pressed() -> void:
	OS.shell_open(Main.fake_ads_url[type])

func _on_Timer_timeout() -> void:
	progress_text.set_visible(false)
	close_button.set_visible(true)

func _on_CloseButton_pressed() -> void:
	root_node.set_visible(false)
	emit_signal("closed")

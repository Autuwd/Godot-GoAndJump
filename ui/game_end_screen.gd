extends Control

const LINES := [
	"某日，出现了一个野猪王",
	"它的出现使人类与野猪的平衡被打破",
	"野猪的肆虐使百姓叫苦不迭",
	"今日，你斩除了这野猪王，获得了胜利",
	"你的胜利，为人类的黑暗迎来了黎明",
	"此刻人们为你欢呼喝彩",
	"帝王赐予你“屠猪勇士”的称号",
	"后人将会以此歌颂你的功绩",
]

var current_line := -1
var tween: Tween

@onready var label: Label = $Label


func _ready() -> void:
	show_line(0)

func _input(event: InputEvent) -> void:
	get_window().set_input_as_handled()
	
	if tween.is_running():
		return
	
	if(
		event is InputEventKey or
		event is InputEventMouse or
		event is InputEventJoypadButton
	):
		if event.is_pressed() and not event.is_echo():
			if current_line + 1 < LINES.size():
				show_line(current_line + 1)
			else:
				Game.back_to_title()


func show_line(line: int) -> void:
	current_line = line
	
	tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	
	if line > 0:
		tween.tween_property(label, "modulate:a", 0, 1)
	else:
		label.modulate.a = 0
	
	tween.tween_callback(label.set_text.bind(LINES[line]))
	tween.tween_property(label, "modulate:a", 1, 1)
	 

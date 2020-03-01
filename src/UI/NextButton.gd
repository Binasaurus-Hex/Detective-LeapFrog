extends NinePatchRect

signal line_finished
var showing:bool = false
var time:float = 0
func _ready() -> void:
	hide()
	
func _physics_process(delta: float) -> void:
	if showing:
		bob(delta)
		_check_click()
		
		
func bob(delta) -> void:
	time += delta * 20
	if(time > 100):
		time = 0
	rect_position.y = lerp(rect_position.y,rect_position.y + sin(time),0.3)
	
func show_btn() -> void:
	show()
	showing = true
	
func hide_btn() -> void:
	hide()
	showing = false
	
func _check_click() -> void:
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("line_finished")
		hide_btn()

extends NinePatchRect

var is_ready:bool = false
var time:float = 0
func _ready() -> void:
	hide()
	Events.connect("dialogue_hide",self,"disband")
	pass
	
func _physics_process(delta: float) -> void:
	if is_ready:
		time += delta * 20
		if(time > 100):
			time = 0
		rect_position.y = lerp(rect_position.y,rect_position.y + sin(time),0.3)
	
func wait() -> void:
	is_ready = true
	show()
	
func disband() -> void:
	is_ready = false
	hide()

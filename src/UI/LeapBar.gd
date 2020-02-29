extends ProgressBar


func _ready() -> void:
	Events.connect("leap_set",self,"set_progress")
	pass
	
func set_progress(value):
	self.value = value

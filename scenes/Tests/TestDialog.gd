extends Cinematic

onready var dialog = $Dialog


func _ready() -> void:
	dialog.start()
	self.emit_signal("cinematic_start")


func _on_Dialog_dialog_finished():
	self.emit_signal("cinematic_end")

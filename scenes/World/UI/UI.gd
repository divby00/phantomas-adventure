extends CanvasLayer

signal inventory_visible(visible)

onready var life_bar: TextureProgress = $LifeBar
onready var tech_container: HBoxContainer = $TechContainer
onready var inventory = $InventoryPanel

func _process(_delta):
	if Input.is_action_just_pressed("Inventory"):
		if (!inventory.visible):
			self.emit_signal("inventory_visible",true)
			inventory.open()
		else:
			inventory.close()
			self.emit_signal("inventory_visible",false)
			
	if (Input.is_action_just_pressed("Cancel") or Input.is_action_just_pressed("ui_cancel")) and inventory.visible:
		inventory.close()
		self.emit_signal("inventory_visible",false)
		


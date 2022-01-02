extends Node2D

const baseItem = preload("res://scenes/Inventory/BaseItem.tscn")

const cursor_desp = 21
onready var cursor = $InventoryCursor
onready var iteminfo = $ItemInfo
onready var items = $Items

var slot = 0

func ready():
	set_process(false)

func open():
	_build_items()
	cursor.position.x = 14
	cursor.position.y = 14
	slot=0
	_show_item_info()
	set_process(true)
	self.visible = true
	
func close():
	self.visible = false
	set_process(false)
	
func _process(_delta):
	if Input.is_action_just_pressed("Left"):
		if (cursor.position.x>14):
			cursor.position.x -= cursor_desp
			slot -= 1
			_show_item_info()
	if Input.is_action_just_pressed("Right"):
		if (cursor.position.x<119):
			cursor.position.x += cursor_desp
			slot += 1
			_show_item_info()
	if Input.is_action_just_pressed("Up"):
		if (cursor.position.y>14):
			cursor.position.y -= cursor_desp
			slot -= 6
			_show_item_info()
	if Input.is_action_just_pressed("Down"):
		if (cursor.position.y<56):
			cursor.position.y += cursor_desp
			slot += 6
			_show_item_info()
		
func _show_item_info():
	if (items.get_child_count()<slot+1):
		iteminfo.text = ""
	else:
		var item = items.get_child(slot)
		iteminfo.text = item.get_info()
		
func _build_items():
	while items.get_child_count() > 0:
		items.remove_child(items.get_child(0))
	var x=14
	var y=14
	for item in GameSlotHandler.GameData.inventory:
		var pitem = baseItem.instance()
		pitem.position.x = x
		pitem.position.y = y
		pitem.icon = item.type
		pitem.count = item.count
		x+=cursor_desp
		if (x>119):
			x=14
			y+=cursor_desp
		items.add_child(pitem)

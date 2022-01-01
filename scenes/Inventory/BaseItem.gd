extends Area2D

signal on_item(item)

enum icontype {
	WORM,CROCHET,HORSESHOE,TROUT,CAT,APPLE,JUG,BLANKET,
	MAGAZINE,SALT,SAUSAGE,WINE,AXE,FIREWOOD,COAL,LOCKPICK,
	BATTERIES,ANTLERS,KEYGOLD,KEYRED,KEYGREEN,
	MANDRAKE,MISTLETOE,BELLADONNA,MUSHROOM
}

export (icontype) var icon:int = icontype.WORM setget _set_icon
export var count:int = 1

onready var sprite:Sprite = $Sprite
var collision: bool = false

func get_id_name() -> String:
	return icontype.keys()[icontype.WALK]

func get_id_label() -> String:
	return "ITEM_"+get_id_name()+"_LABEL"
	
func get_id_text() -> String:
	return "ITEM_"+get_id_name()+"_TEXT"

func _ready():
	_load_icon()

func _process(_delta: float) -> void:
	if collision:
		emit_signal("on_item", self)

func _set_icon(type:int):
	icon = type

func _load_icon():
	var icon_path="res://resources/sprites/inventory/inventory-"+icontype.keys()[icon].to_lower()+".png"
	if (sprite):
		sprite.set_texture(load(icon_path))
		
func _on_BaseItem_body_entered(_body: Node) -> void:
	collision = true

func _on_BaseItem_body_exited(_body: Node) -> void:
	collision = false

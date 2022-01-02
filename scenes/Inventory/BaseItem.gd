extends Area2D

signal on_item(item)

enum icontype {
	NONE=0,ANTLERS=1,APPLE=2,AXE=3,BATTERIES=4,BELLADONNA=5,BLANKET=6,
	CAT=7,COAL=8,CROCHET=9,FIREWOOD=10,HORSESHOE=11,JUG=12,KEYGOLD=13,
	KEYGREEN=14,KEYRED=15,LOCKPICK=16,MAGAZINE=17,MANDRAKE=18,MISTLETOE=19,
	MUSHROOM=20,SALT=21,SAUSAGE=22,TROUT=23,WINE=24,WORM=25
}

export (icontype) var icon:int = icontype.NONE setget _set_icon
export var count:int = 1 setget set_count

onready var sprite:Sprite = $Sprite
onready var infocount:Label = $InfoCount
var collision: bool = false

func set_count(c:int):
	count = c
	if (infocount):
		infocount.text=String(count)
		infocount.visible = (count>1)

func get_id_name() -> String:
	return icontype.keys()[icon]

func get_id_label() -> String:
	return "ITEM_"+get_id_name()+"_LABEL"

func get_id_text() -> String:
	return "ITEM_"+get_id_name()+"_TEXT"

func get_info() -> String:
	return TranslationServer.translate(get_id_label())+":\n"+TranslationServer.translate(get_id_text())

func _ready():
	infocount.visible = false
	_load_icon()
	set_count(count)

func _process(_delta: float) -> void:
	if collision:
		emit_signal("on_item", self)

func _set_icon(type:int):
	icon = type

func _load_icon():
	var icon_path="res://resources/sprites/inventory/inventory-"+icontype.keys()[icon].to_lower()+".png"
	if (icon!=icontype.NONE && sprite):
		sprite.set_texture(load(icon_path))

func _on_BaseItem_body_entered(_body: Node) -> void:
	collision = true

func _on_BaseItem_body_exited(_body: Node) -> void:
	collision = false

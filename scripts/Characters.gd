extends Object
class_name Characters

const data = {
	"Player":
	{
		"name": "Phantomas",
		"portrait": preload("res://resources/sprites/dialogs/portrait-phantomas.png"),
		"background": preload("res://resources/sprites/dialogs/frame-bg-gray.png")
	},
	"Unknown":
	{
		"name": "Extraño",
		"portrait": preload("res://resources/sprites/dialogs/portrait-unknown.png"),
		"background": preload("res://resources/sprites/dialogs/frame-bg-brown.png")
	},
	"Lorenzo":
	{
		"name": "Lorenzo",
		"portrait": preload("res://resources/sprites/dialogs/portrait-lorenzo.png"),
		"background": preload("res://resources/sprites/dialogs/frame-bg-red.png")
	},
	"TioJuan":
	{
		"name": "Tio Juan",
		"portrait": preload("res://resources/sprites/dialogs/portrait-tiojuan.png"),
		"background": preload("res://resources/sprites/dialogs/frame-bg-pink.png")
	},
	"TioRamon":
	{
		"name": "Tio Ramón",
		"portrait": preload("res://resources/sprites/dialogs/portrait-tioramon.png"),
		"background": preload("res://resources/sprites/dialogs/frame-bg-green.png")
	},
	"TiaSimona":
	{
		"name": "Tia Simona",
		"portrait": preload("res://resources/sprites/dialogs/portrait-tiasimona.png"),
		"background": preload("res://resources/sprites/dialogs/frame-bg-blue.png")
	},
	"Agustin":
	{
		"name": "Agustín",
		"portrait": preload("res://resources/sprites/dialogs/portrait-agustin.png"),
		"background": preload("res://resources/sprites/dialogs/frame-bg-brown.png")
	},
	"Maximina":
	{
		"name": "Maximina",
		"portrait": preload("res://resources/sprites/dialogs/portrait-unknown.png"),
		"background": preload("res://resources/sprites/dialogs/frame-bg-red.png")
	},
	"Heladia":
	{
		"name": "Heladia",
		"portrait": preload("res://resources/sprites/dialogs/portrait-unknown.png"),
		"background": preload("res://resources/sprites/dialogs/frame-bg-pink.png")
	},
	"TioEleuterio":
	{
		"name": "Tio Eleuterio",
		"portrait": preload("res://resources/sprites/dialogs/portrait-unknown.png"),
		"background": preload("res://resources/sprites/dialogs/frame-bg-green.png")
	},
	"TioCalixto":
	{
		"name": "Tio Calixto",
		"portrait": preload("res://resources/sprites/dialogs/portrait-unknown.png"),
		"background": preload("res://resources/sprites/dialogs/frame-bg-blue.png")
	},
	"TioValentin":
	{
		"name": "Tio Valentín",
		"portrait": preload("res://resources/sprites/dialogs/portrait-unknown.png"),
		"background": preload("res://resources/sprites/dialogs/frame-bg-brown.png")
	},
	"DonFrancisco":
	{
		"name": "Don Francisco",
		"portrait": preload("res://resources/sprites/dialogs/portrait-unknown.png"),
		"background": preload("res://resources/sprites/dialogs/frame-bg-brown.png")
	},
	"Flora":
	{
		"name": "Flora",
		"portrait": preload("res://resources/sprites/dialogs/portrait-unknown.png"),
		"background": preload("res://resources/sprites/dialogs/frame-bg-brown.png")
	},
	"Felipa":
	{
		"name": "Felipa",
		"portrait": preload("res://resources/sprites/dialogs/portrait-unknown.png"),
		"background": preload("res://resources/sprites/dialogs/frame-bg-brown.png")
	},
	"TioVenancio":
	{
		"name": "Tio Venancio",
		"portrait": preload("res://resources/sprites/dialogs/portrait-unknown.png"),
		"background": preload("res://resources/sprites/dialogs/frame-bg-brown.png")
	},
	"TiaSusana":
	{
		"name": "Tia Susana",
		"portrait": preload("res://resources/sprites/dialogs/portrait-unknown.png"),
		"background": preload("res://resources/sprites/dialogs/frame-bg-brown.png")
	},
	"DomingueroPadre":
	{
		"name": "Dominguero Padre",
		"portrait": preload("res://resources/sprites/dialogs/portrait-unknown.png"),
		"background": preload("res://resources/sprites/dialogs/frame-bg-brown.png")
	},
	"DomingueraMadre":
	{
		"name": "Dominguera Madre",
		"portrait": preload("res://resources/sprites/dialogs/portrait-unknown.png"),
		"background": preload("res://resources/sprites/dialogs/frame-bg-brown.png")
	},
	"DomingueroHijo":
	{
		"name": "Dominguero Hijo",
		"portrait": preload("res://resources/sprites/dialogs/portrait-unknown.png"),
		"background": preload("res://resources/sprites/dialogs/frame-bg-brown.png")
	},
	"DomingueraHija":
	{
		"name": "Dominguera Hija",
		"portrait": preload("res://resources/sprites/dialogs/portrait-unknown.png"),
		"background": preload("res://resources/sprites/dialogs/frame-bg-brown.png")
	},
}


static func get_name(id) -> String:
	return data[id].name


static func get_portrait(id) -> Texture:
	return data[id].portrait


static func get_background(id) -> Texture:
	return data[id].background

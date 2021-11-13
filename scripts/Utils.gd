extends Node


func connect_signal(source, signal_name, target, method_name):
	if not source.is_connected(signal_name, target, method_name):
		source.connect(signal_name, target, method_name)


static func text_file_read(path: String):
	var file = File.new()
	if not file.file_exists(path):
		print("The file " + path + " doesn't exist.")
	else:
		file.open(path, File.READ)
		var text = file.get_as_text()
		file.close()
		return text
	

static func json_file_read(path: String):
	var text = text_file_read(path)
	return JSON.parse(text)


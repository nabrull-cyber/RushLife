extends Node
class_name SaveManager

func salvar(dados: Dictionary):
	var file = FileAccess.open("user://save.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(dados))
	file.close()

func carregar() -> Dictionary:
	if not FileAccess.file_exists("user://save.json"):
		return {}

	var file = FileAccess.open("user://save.json", FileAccess.READ)
	var dados = JSON.parse_string(file.get_as_text())
	file.close()

	return dados

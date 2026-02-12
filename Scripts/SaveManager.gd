extends Node
class_name SaveManager

const SAVE_DIR := "user://saves/"
const SAVE_PREFIX := "slot_"
const SAVE_EXT := ".json"

func _ready() -> void:
	_ensure_dir()

func _ensure_dir() -> void:
	if not DirAccess.dir_exists_absolute(SAVE_DIR):
		DirAccess.make_dir_recursive_absolute(SAVE_DIR)

func _path(slot: int) -> String:
	return SAVE_DIR + SAVE_PREFIX + str(slot) + SAVE_EXT

func salvar(slot: int, data: Dictionary) -> void:
	_ensure_dir()
	var file := FileAccess.open(_path(slot), FileAccess.WRITE)
	if file == null:
		return
	file.store_string(JSON.stringify(data, "\t"))
	file.close()

func carregar(slot: int) -> Dictionary:
	var path := _path(slot)
	if not FileAccess.file_exists(path):
		return {}
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		return {}
	var txt := file.get_as_text()
	file.close()

	var parsed := JSON.parse_string(txt)
	if typeof(parsed) == TYPE_DICTIONARY:
		return parsed
	return {}

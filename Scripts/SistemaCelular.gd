extends Node
class_name SistemaCelular

# Esse script é o "modelo" do celular (lógica).
# A interface visual (UI) vem depois.

var papel_de_parede: String = "wall_default"
var brilho: float = 0.8
var fonte_tamanho: int = 16

# Grade simples: posição do app na tela inicial
# Ex: {"id":"bank", "x":0, "y":0}
var apps: Array = []

func _ready():
	_carregar_apps_padrao()

func _carregar_apps_padrao():
	apps = [
		{"id":"lifestatus", "nome":"LifeStatus", "x":0, "y":0},
		{"id":"bank", "nome":"VirellaBank", "x":1, "y":0},
		{"id":"store", "nome":"Loja Online", "x":2, "y":0},
		{"id":"music", "nome":"Som & Rádio", "x":0, "y":1},
		{"id":"config", "nome":"Config", "x":1, "y":1},
	]

func mover_app(app_id: String, novo_x: int, novo_y: int) -> bool:
	for a in apps:
		if a["id"] == app_id:
			a["x"] = clamp(novo_x, 0, 4)
			a["y"] = clamp(novo_y, 0, 6)
			return true
	return false

func set_papel_de_parede(id_wall: String) -> void:
	papel_de_parede = id_wall

func set_brilho(valor: float) -> void:
	brilho = clamp(valor, 0.1, 1.0)

func set_fonte_tamanho(valor: int) -> void:
	fonte_tamanho = clamp(valor, 12, 30)

func to_dict() -> Dictionary:
	return {
		"papel_de_parede": papel_de_parede,
		"brilho": brilho,
		"fonte_tamanho": fonte_tamanho,
		"apps": apps
	}

func from_dict(d: Dictionary) -> void:
	papel_de_parede = str(d.get("papel_de_parede", papel_de_parede))
	brilho = float(d.get("brilho", brilho))
	fonte_tamanho = int(d.get("fonte_tamanho", fonte_tamanho))
	apps = d.get("apps", apps)


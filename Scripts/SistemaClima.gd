extends Node
class_name SistemaClima

enum Clima { SOL, CHUVA, FRIO, CALOR, NEVE }

var clima_atual: int = Clima.SOL

signal clima_mudou(clima_atual)

func sortear_clima():
	# Pesos simples (ajustamos depois):
	# Sol mais comum, neve mais rara
	var pool = [
		Clima.SOL, Clima.SOL, Clima.SOL,
		Clima.CALOR, Clima.CALOR,
		Clima.CHUVA, Clima.CHUVA,
		Clima.FRIO, Clima.FRIO,
		Clima.NEVE
	]
	clima_atual = pool.pick_random()
	emit_signal("clima_mudou", clima_atual)

func get_nome_clima() -> String:
	match clima_atual:
		Clima.SOL: return "Sol"
		Clima.CHUVA: return "Chuva"
		Clima.FRIO: return "Frio"
		Clima.CALOR: return "Calor"
		Clima.NEVE: return "Neve"
		_: return "Desconhecido"


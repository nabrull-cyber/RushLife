extends Node
class_name SistemaTempo

# Tempo do jogo
var dia: int = 1
var hora: int = 8
var minuto: int = 0

# Velocidade do tempo:
# 1 segundo real = 1 minuto do jogo (ajuste depois como quiser)
var minutos_por_tick: int = 1

signal tempo_mudou(dia, hora, minuto)

func avancar_tempo():
	minuto += minutos_por_tick

	if minuto >= 60:
		minuto = 0
		hora += 1

	if hora >= 24:
		hora = 0
		dia += 1

	emit_signal("tempo_mudou", dia, hora, minuto)

func get_horario_formatado() -> String:
	return str(hora).pad_zeros(2) + ":" + str(minuto).pad_zeros(2)

extends Node
class_name SistemaIdade

# Modos:
# HISTORIA: envelhece naturalmente
# LIVRE: jogador pode mudar a idade quando quiser
enum Modo { HISTORIA, LIVRE }

var modo: int = Modo.HISTORIA

# Idade em anos
var idade: int = 18

# Se HISTORIA, controla a progressão
var envelhecimento_ativo: bool = true
var dias_para_1_ano: int = 120   # 120 dias do jogo = 1 ano (pode ajustar depois)
var _dias_acumulados: int = 0

signal idade_mudou(nova_idade: int)

func configurar(m: int, idade_inicial: int) -> void:
	modo = m
	idade = idade_inicial
	emit_signal("idade_mudou", idade)

func on_novo_dia() -> void:
	if modo != Modo.HISTORIA:
		return
	if not envelhecimento_ativo:
		return

	_dias_acumulados += 1
	if _dias_acumulados >= dias_para_1_ano:
		_dias_acumulados = 0
		idade += 1
		emit_signal("idade_mudou", idade)

# Só funciona no modo LIVRE
func set_idade_livre(nova_idade: int) -> void:
	if modo != Modo.LIVRE:
		return
	idade = clamp(nova_idade, 1, 99)
	emit_signal("idade_mudou", idade)

func to_dict() -> Dictionary:
	return {
		"modo": modo,
		"idade": idade,
		"envelhecimento_ativo": envelhecimento_ativo,
		"dias_para_1_ano": dias_para_1_ano,
		"dias_acumulados": _dias_acumulados
	}

func from_dict(d: Dictionary) -> void:
	modo = int(d.get("modo", modo))
	idade = int(d.get("idade", idade))
	envelhecimento_ativo = bool(d.get("envelhecimento_ativo", envelhecimento_ativo))
	dias_para_1_ano = int(d.get("dias_para_1_ano", dias_para_1_ano))
	_dias_acumulados = int(d.get("dias_acumulados", _dias_acumulados))

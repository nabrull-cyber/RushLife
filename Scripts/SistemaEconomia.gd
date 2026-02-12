extends Node
class_name SistemaEconomia

var inflacao = 1.0

func calcular_preco(base):
	return int(base * inflacao)


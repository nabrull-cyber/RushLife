extends Node
class_name SistemaTrabalho

func pagamento(tipo):
	if tipo == "ENTREGA":
		return 20
	elif tipo == "UBER":
		return 30
	return 10


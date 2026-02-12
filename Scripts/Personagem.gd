extends Node
class_name Personagem

var nome: String = "Jogador"

# Status
var fome: int = 100
var saude: int = 100
var energia: int = 100
var social_xp: int = 0

# Economia
var saldo: int = 50

# Transporte
var veiculo_id: String = "bike_basic"  # usa IDs do SistemaVeiculos
var veiculo_nome: String = "Bicicleta Urbana"

func trabalhar(tipo: String) -> int:
	var ganho := 0
	match tipo:
		"ENTREGA":
			ganho = 20
		"UBER":
			ganho = 30
		_:
			ganho = 10
	saldo += ganho

	# custo de energia/fome
	energia = clamp(energia - 8, 0, 100)
	fome = clamp(fome - 6, 0, 100)

	return ganho

func comprar(preco: int) -> bool:
	if saldo >= preco:
		saldo -= preco
		return true
	return false

func atualizar_status_por_tempo() -> void:
	# Ajuste leve por minuto/hora (depois refinamos)
	fome = clamp(fome - 1, 0, 100)
	energia = clamp(energia - 1, 0, 100)
	if fome <= 10 or energia <= 10:
		saude = clamp(saude - 1, 0, 100)

func to_dict() -> Dictionary:
	return {
		"nome": nome,
		"fome": fome,
		"saude": saude,
		"energia": energia,
		"social_xp": social_xp,
		"saldo": saldo,
		"veiculo_id": veiculo_id,
		"veiculo_nome": veiculo_nome
	}

func from_dict(d: Dictionary) -> void:
	nome = str(d.get("nome", nome))
	fome = int(d.get("fome", fome))
	saude = int(d.get("saude", saude))
	energia = int(d.get("energia", energia))
	social_xp = int(d.get("social_xp", social_xp))
	saldo = int(d.get("saldo", saldo))
	veiculo_id = str(d.get("veiculo_id", veiculo_id))
	veiculo_nome = str(d.get("veiculo_nome", veiculo_nome))

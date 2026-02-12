extends Node
class_name SistemaVeiculos

# Classes: POPULAR, INTERMEDIARIO, EXECUTIVO, LUXO
# Tipos: BICICLETA, MOTO, CARRO

enum Tipo { BICICLETA, MOTO, CARRO }
enum Classe { POPULAR, INTERMEDIARIO, EXECUTIVO, LUXO }

var catalogo: Array = []

func _ready():
	_carregar_catalogo_padrao()

func _carregar_catalogo_padrao():
	catalogo = [
		# BICICLETAS
		{"id":"bike_basic", "tipo":Tipo.BICICLETA, "classe":Classe.POPULAR, "nome":"Bicicleta Urbana", "vel":14, "custo_km":0, "preco":120},
		{"id":"bike_sport", "tipo":Tipo.BICICLETA, "classe":Classe.INTERMEDIARIO, "nome":"Bicicleta Sport", "vel":18, "custo_km":0, "preco":300},

		# MOTOS
		{"id":"moto_city", "tipo":Tipo.MOTO, "classe":Classe.POPULAR, "nome":"Moto City 125", "vel":26, "custo_km":1, "preco":3500},
		{"id":"moto_street", "tipo":Tipo.MOTO, "classe":Classe.INTERMEDIARIO, "nome":"Moto Street 160", "vel":30, "custo_km":1, "preco":5200},
		{"id":"moto_tour", "tipo":Tipo.MOTO, "classe":Classe.EXECUTIVO, "nome":"Moto Tour 300", "vel":34, "custo_km":2, "preco":12000},

		# CARROS
		{"id":"car_hatch", "tipo":Tipo.CARRO, "classe":Classe.POPULAR, "nome":"Hatch Compact", "vel":32, "custo_km":3, "preco":18000},
		{"id":"car_sedan", "tipo":Tipo.CARRO, "classe":Classe.INTERMEDIARIO, "nome":"Sedan Confort", "vel":36, "custo_km":4, "preco":35000},
		{"id":"car_exec", "tipo":Tipo.CARRO, "classe":Classe.EXECUTIVO, "nome":"Executive Line", "vel":40, "custo_km":5, "preco":78000},
		{"id":"car_lux", "tipo":Tipo.CARRO, "classe":Classe.LUXO, "nome":"Lux Grand", "vel":44, "custo_km":7, "preco":160000},
	]

func listar_por_tipo(tipo: int) -> Array:
	var r: Array = []
	for v in catalogo:
		if v["tipo"] == tipo:
			r.append(v)
	return r

func pegar_por_id(id: String) -> Dictionary:
	for v in catalogo:
		if v["id"] == id:
			return v
	return {}

func pode_comprar(personagem: Personagem, id: String) -> bool:
	var v := pegar_por_id(id)
	if v.is_empty():
		return false
	return personagem.saldo >= int(v["preco"])

func comprar(personagem: Personagem, id: String) -> bool:
	var v := pegar_por_id(id)
	if v.is_empty():
		return false

	var preco := int(v["preco"])
	if personagem.saldo < preco:
		return false

	personagem.saldo -= preco
	personagem.veiculo = v["nome"]
	return true

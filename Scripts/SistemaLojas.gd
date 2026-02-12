extends Node
class_name SistemaLojas

# Tipos de loja
enum LojaTipo { SUPERMERCADO, FARMACIA, ROUPAS, MECANICO, PETS, TELEFONES, ALIMENTACAO }

var lojas: Array = []

func _ready():
	_carregar_lojas_padrao()

func _carregar_lojas_padrao():
	lojas = [
		{
			"id":"market_sun",
			"tipo":LojaTipo.SUPERMERCADO,
			"nome":"Mercado Sol & Cia",
			"itens":[
				{"id":"arroz", "nome":"Arroz (1kg)", "preco":12, "efeito":{"fome":+10}},
				{"id":"fruta", "nome":"Frutas Mix", "preco":8, "efeito":{"fome":+6, "saude":+2}},
				{"id":"lanche", "nome":"Lanche rápido", "preco":15, "efeito":{"fome":+15, "energia":+2}}
			]
		},
		{
			"id":"pharma_vita",
			"tipo":LojaTipo.FARMACIA,
			"nome":"VitaFarma",
			"itens":[
				{"id":"xarope_simples", "nome":"Xarope simples", "preco":10, "efeito":{"saude":+5}},
				{"id":"antigripal", "nome":"Antigripal", "preco":22, "efeito":{"saude":+12}},
				{"id":"vitamina", "nome":"Vitamina diária", "preco":35, "efeito":{"saude":+8, "energia":+5}}
			]
		},
		{
			"id":"wear_urban",
			"tipo":LojaTipo.ROUPAS,
			"nome":"UrbanWear",
			"itens":[
				{"id":"camiseta", "nome":"Camiseta básica", "preco":25, "efeito":{}},
				{"id":"casaco", "nome":"Casaco de frio", "preco":90, "efeito":{"resistencia_frio":+1}},
				{"id":"capa_chuva", "nome":"Capa de chuva (motoboy)", "preco":110, "efeito":{"resistencia_chuva":+1}}
			]
		},
		{
			"id":"fix_mec",
			"tipo":LojaTipo.MECANICO,
			"nome":"Oficina FixCar",
			"itens":[
				{"id":"revisao", "nome":"Revisão simples", "preco":80, "efeito":{"veiculo_estado":+10}},
				{"id":"pneu", "nome":"Troca de pneu", "preco":120, "efeito":{"veiculo_estado":+15}}
			]
		},
		{
			"id":"pet_mundo",
			"tipo":LojaTipo.PETS,
			"nome":"MundoPet",
			"itens":[
				{"id":"racao", "nome":"Ração (pequena)", "preco":18, "efeito":{}},
				{"id":"brinquedo_pet", "nome":"Brinquedo pet", "preco":22, "efeito":{}}
			]
		},
		{
			"id":"cellix_store",
			"tipo":LojaTipo.TELEFONES,
			"nome":"Cellix Store",
			"itens":[
				{"id":"cellix_start", "nome":"Cellix Start", "preco":500, "efeito":{"telefone": "Cellix Start"}},
				{"id":"cellix_nova", "nome":"Cellix Nova", "preco":1200, "efeito":{"telefone": "Cellix Nova"}},
				{"id":"cellix_prime", "nome":"Cellix Prime", "preco":2400, "efeito":{"telefone": "Cellix Prime"}}
			]
		},
		{
			"id":"food_style",
			"tipo":LojaTipo.ALIMENTACAO,
			"nome":"Estilo Alimentar",
			"itens":[
				{"id":"vegano_pack", "nome":"Kit Vegano", "preco":30, "efeito":{"fome":+12, "saude":+6}},
				{"id":"vegetariano_pack", "nome":"Kit Vegetariano", "preco":28, "efeito":{"fome":+12, "saude":+4}}
			]
		},
	]

func listar_lojas() -> Array:
	return lojas

func get_loja(id: String) -> Dictionary:
	for l in lojas:
		if l["id"] == id:
			return l
	return {}

func comprar_item(personagem: Personagem, loja_id: String, item_id: String) -> bool:
	var loja := get_loja(loja_id)
	if loja.is_empty():
		return false

	for it in loja["itens"]:
		if it["id"] == item_id:
			var preco := int(it["preco"])
			if personagem.saldo < preco:
				return false

			personagem.saldo -= preco
			_aplicar_efeito(personagem, it.get("efeito", {}))
			return true

	return false

func _aplicar_efeito(personagem: Personagem, efeito: Dictionary) -> void:
	# Efeitos básicos
	if efeito.has("fome"):
		personagem.fome = clamp(personagem.fome + int(efeito["fome"]), 0, 100)
	if efeito.has("saude"):
		personagem.saude = clamp(personagem.saude + int(efeito["saude"]), 0, 100)
	if efeito.has("energia"):
		personagem.energia = clamp(personagem.energia + int(efeito["energia"]), 0, 100)
	# Telefone (placeholder: depois criamos classe Telefone)
	if efeito.has("telefone"):
		# você pode salvar em personagem.telefone futuramente
		pass

extends Node
class_name GameManager

# Core
var save: SaveManager
var config: ConfigManager

# Player
var personagem: Personagem

# Systems
var tempo: SistemaTempo
var clima: SistemaClima
var economia: SistemaEconomia
var trabalho: SistemaTrabalho
var relacao: SistemaRelacao

# Novos (A, B, C, D)
var veiculos: SistemaVeiculos
var lojas: SistemaLojas
var idade: SistemaIdade
var celular: SistemaCelular

signal jogo_iniciado
signal jogo_salvo(slot: int)
signal jogo_carregado(slot: int)

func _ready() -> void:
	randomize()

	# Core
	save = SaveManager.new()
	config = ConfigManager.new()
	add_child(save)
	add_child(config)

	# Player
	personagem = Personagem.new()
	add_child(personagem)

	# Systems
	tempo = SistemaTempo.new()
	clima = SistemaClima.new()
	economia = SistemaEconomia.new()
	trabalho = SistemaTrabalho.new()
	relacao = SistemaRelacao.new()

	add_child(tempo)
	add_child(clima)
	add_child(economia)
	add_child(trabalho)
	add_child(relacao)

	# A, B, C, D
	veiculos = SistemaVeiculos.new()
	lojas = SistemaLojas.new()
	idade = SistemaIdade.new()
	celular = SistemaCelular.new()

	add_child(veiculos)
	add_child(lojas)
	add_child(idade)
	add_child(celular)

	# Ligações úteis
	tempo.tick.connect(_on_tempo_tick)
	clima.clima_mudou.connect(_on_clima_mudou)

	# Estado inicial
	clima.sortear_clima()
	emit_signal("jogo_iniciado")

func _on_tempo_tick(_dia: int, _hora: int, _minuto: int) -> void:
	# Atualiza status do personagem com o tempo
	if personagem.has_method("atualizar_status_por_tempo"):
		personagem.atualizar_status_por_tempo()

	# A cada novo dia (00:00) envelhece (se ativo)
	if _hora == 0 and _minuto == 0:
		idade.avancar_dia()

func _on_clima_mudou(_novo: int) -> void:
	# Placeholder: aqui depois ligamos áudio, roupas, resfriado etc.
	pass

# ---------------- SAVE / LOAD ----------------

func salvar(slot: int = 1) -> void:
	var data := {
		"version": "0.0.1",
		"config": config.to_dict(),

		"personagem": personagem.to_dict(),
		"tempo": tempo.to_dict(),
		"clima": clima.to_dict(),
		"economia": economia.to_dict(),
		"trabalho": trabalho.to_dict(),
		"relacao": relacao.to_dict(),

		"veiculos": {}, # catálogo é fixo, não precisa salvar agora
		"lojas": {},    # catálogo é fixo, não precisa salvar agora
		"idade": idade.to_dict(),
		"celular": celular.to_dict()
	}

	save.salvar(slot, data)
	emit_signal("jogo_salvo", slot)

func carregar(slot: int = 1) -> void:
	var data := save.carregar(slot)
	if data.is_empty():
		return

	# Restore
	if data.has("config"): config.from_dict(data["config"])

	if data.has("personagem"): personagem.from_dict(data["personagem"])
	if data.has("tempo"): tempo.from_dict(data["tempo"])
	if data.has("clima"): clima.from_dict(data["clima"])
	if data.has("economia"): economia.from_dict(data["economia"])
	if data.has("trabalho"): trabalho.from_dict(data["trabalho"])
	if data.has("relacao"): relacao.from_dict(data["relacao"])

	if data.has("idade"): idade.from_dict(data["idade"])
	if data.has("celular"): celular.from_dict(data["celular"])

	emit_signal("jogo_carregado", slot)

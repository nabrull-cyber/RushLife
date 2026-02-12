extends Node
class_name GameManager

var personagem: Personagem
var tempo: SistemaTempo
var clima: SistemaClima
var economia: SistemaEconomia
var trabalho: SistemaTrabalho
var relacao: SistemaRelacao

func _ready():
	randomize()

	personagem = Personagem.new()
	tempo = SistemaTempo.new()
	clima = SistemaClima.new()
	economia = SistemaEconomia.new()
	trabalho = SistemaTrabalho.new()
	relacao = SistemaRelacao.new()

	add_child(personagem)
	add_child(tempo)
	add_child(clima)
	add_child(economia)
	add_child(trabalho)
	add_child(relacao)

	clima.sortear_clima()

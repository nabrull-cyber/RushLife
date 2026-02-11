extends Node

class_name Personagem

# ===== ATRIBUTOS PRINCIPAIS =====
var nome: String = "Player"
var genero: String = "Indefinido"

# Status
var fome: float = 100
var saude: float = 100
var energia: float = 100
var humor: float = 100
var estresse: float = 0

# Economia
var saldo: float = 50

# Transporte
var veiculo: String = "Bicicleta Básica"

# Relacionamentos
var parceiro = null
var filhos: Array = []

# ===== FUNÇÕES =====

func comer(valor: float):
	fome = clamp(fome + valor, 0, 100)

func descansar(valor: float):
	energia = clamp(energia + valor, 0, 100)
	estresse = clamp(estresse - 5, 0, 100)

func trabalhar(tipo: String):
	if energia < 20:
		print("Você está muito cansado para trabalhar.")
		return
	
	if tipo == "entrega":
		saldo += 20
	elif tipo == "uber":
		saldo += 30
	
	energia -= 15
	estresse += 10
	fome -= 10

func comprar(valor: float) -> bool:
	if saldo >= valor:
		saldo -= valor
		return true
	return false

func atualizar_status():
	fome -= 0.05
	energia -= 0.03
	
	if fome <= 0:
		saude -= 0.1
	
	fome = clamp(fome, 0, 100)
	energia = clamp(energia, 0, 100)
	saude = clamp(saude, 0, 100)


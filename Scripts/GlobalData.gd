extends Node

const max_difficulty = 5 # a dificuldade máxima do jogo
# nos arrays abaixo, cada indice é correspondente a uma dificuldade em ordem crescente


const difficulty_map = [0.0, 20.0, 40.0, 60.0, 80.0, 100.0, 120.0]
#esse array significa o tempo em segundos onde começa cada dificuldade
#inicialmente, a dificuldade 0 começa após 0 segundos, 
# a dificuldade 1 ocorrerá depois de 20 segundos e assim por diante

const min_time = [19.0, 15.0, 12.0, 10.0, 8.0, 6.0]
#esse é o tempo mínimo da paciência do customer em cada dificuldade

const max_time = [25.0, 23.0, 19.0, 15.0, 13.0, 10.0]
#tempo maximo da paciencia do customer em cada dificuldade

const first_spawn_time = 5.0

const spawn_time = [12.0, 10.0, 8.0, 6.0, 4.0, 3.0]
#tempo que o spawner demora par spawnar o próximo customer em cada dificuldade

var lost_state = 0 #usar isso no ready do menu para saber o que mostrar
# 0 == começou agora, 1 == perdeu por alimentar errado, 2 == perdeu por inanição
# quando o jogador perde, ele vai chamar get_tree().change_scene(Menu),
# o valor dessa variavel lost_state serve para dizer como ele perdeu
# se o valor for zero, significa que ele acabou de abrir o jogo
# ou seja, no ready da menu scene, acessaremos essa variavel pra ver se mostra uma
#tela de derrota antes de mostrar o menu ou já mostra o menu direto

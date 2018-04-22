extends Node

const max_difficulty = 3
const difficulty_map = [0.0, 20.0, 50.0, 80.0]
const min_time = [15.0, 12.0, 10.0, 8.0]
const max_time = [25.0, 23.0, 19.0, 15.0]
const spawn_time = [13.0, 10.0, 7.0, 4.0]

var lost_state = 0 #usar isso no ready do menu para saber o que mostrar
# 0 == começou agora, 1 == perdeu por alimentar errado, 2 == perdeu por inanição

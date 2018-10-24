require './engine'

p1 = Player.new "1"
p2 = Player.new "2"
b = Board.new(players: [p1, p2], call_size: 3)

engine = Engine.new b

engine.run
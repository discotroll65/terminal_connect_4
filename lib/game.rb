require 'pry-byebug'
require_relative 'board.rb'

board = Board.new
red = Piece.new(color: :red)
black = Piece.new(color: :black)

board.move(0, red)
board.move(1, red)
binding.pry
board.check_win([5,0])
board.render


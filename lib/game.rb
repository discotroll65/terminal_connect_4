require 'pry-byebug'
require_relative 'board.rb'

board = Board.new
piece = Piece.new(color: :red)
board.move(0, piece)
board.move(1, piece)
binding.pry
board.check_win([5,0])
board.render


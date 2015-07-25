require 'pry-byebug'
require_relative 'board.rb'

board = Board.new
piece = Piece.new(color: :red)
6.times do
  board.move(0, piece)
end
binding.pry
board.render


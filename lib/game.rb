require 'pry-byebug'
require_relative 'board.rb'

puts "Welcome to Connect X"
puts
puts "enter rows of the board(6 is normal):"
rows = gets.strip.to_i
puts "enter the cols of the board (7 is normal):"
cols = gets.strip.to_i
puts "enter the number of cells to connect (4 is normal):"
win_size = gets.strip.to_i

board = Board.new(row: rows, col: cols, win_size: win_size)

red = Piece.new(color: :red)
black = Piece.new(color: :black)

turn = "Black"

board.render
while true

  puts "#{turn}, enter col to move:"
  move_col = gets.strip.to_i
  piece = turn== "Black" ? black : red
  last_move = board.move(move_col, piece)
  board.render

  if board.check_win(last_move)
   
    puts "Winner!"
    break
  elsif board.board_full?
    puts "no more moves!"
    break
  end
  turn = turn == "Black" ? "Red" : "Black"
end



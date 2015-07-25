require 'colorize'
require_relative 'piece.rb'
class Board
  attr_reader :grid
  def initialize (options = {:row => 6, :col => 7})
    @grid = Array.new(options[:row]){Array.new(options[:col]){nil}}
  end

  def render
    rendered_rows = []
    grid.each do |row|
      row_string=""
      row.each do |piece|
        if piece.nil?
          rendered_piece =  " |".colorize(background: :blue)
        else
          rendered_piece =  "@|".colorize(background: :blue, color: piece.color)
        end
        row_string += rendered_piece
      end
      rendered_rows << "|".colorize(background: :blue) + row_string + "\n"
    end

    puts rendered_rows.join('')
    puts
    puts
  end

  def [](x, y)
    grid[x][y]
  end

  def []= (x, y, piece)
    grid[x][y] = piece
  end

  def move(col_num, piece)
    raise "Column full!" if is_full?(col_num)
    grid.length.times do |i|
      if i == grid.length - 1 || !self[i + 1, col_num].nil?
        self[i, col_num] = piece
        render
        return
      end
    end
  end

  def is_full?(col_num)
    !self[0,col_num].nil? 
  end

end


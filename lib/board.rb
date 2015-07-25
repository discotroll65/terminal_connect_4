require 'colorize'
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
  end

  def [](x, y)
    grid[x][y]
  end

end


require 'colorize'
require_relative 'piece.rb'
class Board
  attr_reader :grid
  attr_reader :win_size
  PROBE_MAP = {
    right: [0 , 1],
    left: [0, -1],
    upright: [-1, 1],
    downleft: [1,-1],
    upleft: [-1, -1],
    downright: [1, 1],
    down: [1, 0]
  }

  def initialize (options = {:row => 6, :col => 7, :win_size => 4})
    @grid = Array.new(options[:row]){Array.new(options[:col]){false}}
    @win_size = options[:win_size]
  end

  def render
    rendered_rows = []
    grid.each do |row|
      row_string= ""
      row.each do |piece|
        if !piece
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
    raise "out of board!" if grid[x].nil?
    grid[x][y]
  end

  def []= (x, y, piece)
    return nil if self[x,y]
    grid[x][y] = piece
  end

  def move(col_num, piece)
    raise "Column full!" if is_full?(col_num)
    grid.length.times do |i|
      if i == grid.length - 1 || !!self[i + 1, col_num]
        self[i, col_num] = piece
        return [i, col_num]
      end
    end
  end

  def check_win(pos)
    row, col = pos
    return false unless self[row,col]
    color = self[row, col].color

    result =  check_ho(pos, color)

    #check_vert(pos, color)
    #check_positive_diag(pos, color)
    #check_negative_diag(pos, color)
    result ? (puts "won!") : (puts "nope")
  end

  def check_ho(pos, color)
    sum_right = probe(:right, pos, color)
    sum_left = probe(:left, pos, color)

    sum_right + sum_left == win_size - 1 
  end

  def check_positive_diag(pos, color)
    sum_upright = probe(:upright, pos, color)
    sum_downleft = probe(:downleft, pos, color)

    sum_upright + sum_downleft == win_size - 1
  end
  
  def check_negative_diag(pos, color)
    sum_downright = probe(:upleft, pos, color)
    sum_upleft = probe(:downright, pos, color)

    sum_upleft + sum_downright == win_size - 1
  end

  def check_vert(pos, color)
    sum_down = probe(:down, pos, color)

    sum_down == win_size - 1
  end

  def probe(dir, pos, color)
    row, col = pos
    count = 0
    x_probe_dir, y_probe_dir = PROBE_MAP[dir]
     
    while true
      begin
        probed = self[row + x_probe_dir, col + y_probe_dir]
      rescue
        return count
      end

      if probed && probed.color == color
        count += 1
        row += x_probe_dir
        col += y_probe_dir
      else
        return count
      end
    end
  end

  def is_full?(col_num)
    !!self[0,col_num] 
  end

end


class Piece
  attr_reader :color
  def initialize(options)
    @color = options[:color]
  end
end

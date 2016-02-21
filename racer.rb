class Racer
  attr_reader :x, :y

  def initialize(window)
    @x, @y = 400, 500
    @image = Gosu::Image.new("images/ship.png")
    @window = window
  end

  def draw
    @image.draw_rot(@x, @y, 1, 0)
  end
end

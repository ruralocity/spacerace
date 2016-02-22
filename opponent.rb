class Opponent
  SPEED = 5
  attr_reader :x, :y, :radius
  attr_accessor :passed

  def initialize(window)
    @radius = 20
    @x = rand(window.width - 2 * @radius) + @radius
    @y = 0
    @image = Gosu::Image.new("images/ship.png")
    @passed = false
  end

  def move
    @y += SPEED
  end

  def draw
    @image.draw(@x - @radius, @y - @radius, 1)
  end
end
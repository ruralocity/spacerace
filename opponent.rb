class Opponent
  BASE_SPEED = 5
  attr_reader :x, :y, :radius
  attr_accessor :passed

  def initialize(window)
    @radius = 20
    @x = rand(window.width - 2 * @radius) + @radius
    @y = 0
    @speed = BASE_SPEED + rand(0..7)
    @image = Gosu::Image.new("images/ship.png")
    @passed = false
  end

  def move
    @y += @speed
  end

  def draw
    @image.draw(@x - @radius, @y - @radius, 1)
  end
end
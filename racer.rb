class Racer
  attr_reader :x, :y

  def initialize(window)
    @x, @y = 200, 500
    @image = Gosu::Image.new("images/ship.png")
    @radius = 20
    @window = window
  end

  def draw
    @image.draw_rot(@x, @y, 1, 0)
  end

  def move_left
    @x -= 10
  end

  def move_right
    @x += 10
  end

  def move
    if @x > @window.width - @radius
      @x = @window.width - @radius
    end

    if @x < @radius
      @x = @radius
    end
  end
end

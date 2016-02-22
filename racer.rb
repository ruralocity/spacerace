class Racer
  attr_reader :x, :y

  def initialize(window)
    @image = Gosu::Image.new("images/ship.png")
    @radius = 20
    @window = window
    @x, @y = @window.width / 2, @window.height - 100
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

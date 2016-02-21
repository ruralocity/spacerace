require "gosu"
require_relative "racer"

class SpaceRace < Gosu::Window
  WIDTH, HEIGHT = 400, 600

  def initialize
    super(WIDTH, HEIGHT)
    self.caption = "Space Race"
    @racer = Racer.new(self)
  end

  def draw
    @racer.draw
  end

  def update
    @racer.move_left if button_down?(Gosu::KbLeft)
    @racer.move_right if button_down?(Gosu::KbRight)
    @racer.move
  end
end

window = SpaceRace.new
window.show

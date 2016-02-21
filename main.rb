require "gosu"
require_relative "racer"

class SpaceRace < Gosu::Window
  WIDTH, HEIGHT = 800, 600

  def initialize
    super(WIDTH, HEIGHT)
    self.caption = "Space Race"
    @racer = Racer.new(self)
  end

  def draw
    @racer.draw
  end
end

window = SpaceRace.new
window.show

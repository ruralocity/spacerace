require "gosu"

class SpaceRace < Gosu::Window
  WIDTH, HEIGHT = 800, 600

  def initialize
    super(WIDTH, HEIGHT)
    self.caption = "Space Race"
  end
end

window = SpaceRace.new
window.show

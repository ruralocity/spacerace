require "gosu"
require_relative "racer"
require_relative "opponent"

class SpaceRace < Gosu::Window
  WIDTH, HEIGHT = 200, 600
  OPPONENT_FREQUENCY = 0.01

  def initialize
    super(WIDTH, HEIGHT)
    self.caption = "Space Race"
    @racer = Racer.new(self)
    @opponents = []
    @score = 0
    @score_display = Gosu::Font.new(28)
  end

  def draw
    @racer.draw
    @opponents.each do |opponent|
      opponent.draw
    end

    @score_display.draw(@score, 160, 20, 1, 1, 1, Gosu::Color::AQUA)
  end

  def update
    @racer.move_left if button_down?(Gosu::KbLeft)
    @racer.move_right if button_down?(Gosu::KbRight)
    @racer.move

    if rand < OPPONENT_FREQUENCY
      @opponents.push Opponent.new(self)
    end

    @opponents.each do |opponent|
      opponent.move
      if (opponent.y + opponent.radius > @racer.y + @racer.radius) && !opponent.passed
        @score += 1
        opponent.passed = true
      end
    end
  end
end

window = SpaceRace.new
window.show

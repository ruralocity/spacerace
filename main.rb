require "gosu"
require_relative "racer"
require_relative "opponent"

class SpaceRace < Gosu::Window
  WIDTH, HEIGHT = 200, 600
  OPPONENT_FREQUENCY = 0.01

  def initialize
    super(WIDTH, HEIGHT)
    self.caption = "Space Race"
    @background = Gosu::Image.new("images/background.png", tilable: true)
    @racer = Racer.new(self)
    @opponents = []
    @score = 0
    @score_display = Gosu::Font.new(28)
    @scene = :game
  end

  def draw
    case @scene
    when :game
      draw_game
    when :end
      draw_end
    end
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

      if collision?(opponent, @racer)
        @scene = :end
      end
    end

    @opponents.dup.each do |opponent|
      if opponent.y > HEIGHT + opponent.radius
        @opponents.delete opponent
      end
    end
  end

  private

  def draw_game
    @background.draw(0, 0, 0)
    @racer.draw
    @opponents.each do |opponent|
      opponent.draw
    end

    @score_display.draw(@score, 160, 20, 1, 1, 1, Gosu::Color::AQUA)
  end

  def draw_end
    @background.draw(0, 0, 0)
    @game_over = Gosu::Font.new(32)
    @game_over.draw("Game Over", 10, 200, 3)
    @game_over.draw("Final Score:", 10, 250, 3)
    @game_over.draw("#{@score}", 10, 300, 3)
  end

  def collision?(entity1, entity2)
    if entity1 && entity2
      distance = Gosu.distance(entity1.x, entity1.y, entity2.x, entity2.y)
      distance < entity2.radius + entity1.radius
    end
  end
end

window = SpaceRace.new
window.show

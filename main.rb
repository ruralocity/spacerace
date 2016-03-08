require "gosu"
require_relative "racer"
require_relative "opponent"
require_relative "explosion"
require_relative "fuel_pellet"

class SpaceRace < Gosu::Window
  WIDTH, HEIGHT = 200, 600
  OPPONENT_FREQUENCY = 0.01
  FUEL_FREQUENCY = 0.001
  TIME_LIMIT = 60 # seconds

  def initialize
    super(WIDTH, HEIGHT)
    self.caption = "Space Race"
    @background = Gosu::Image.new("images/background.png", tilable: true)
    @racer = Racer.new(self)
    @opponents = []
    @explosions = []
    @fuel_pellets = []
    @passing_sound = Gosu::Sample.new("sounds/passing.ogg")
    @explosion_sound = Gosu::Sample.new("sounds/explosion.ogg")
    @fuelup_sound = Gosu::Sample.new("sounds/fuel.ogg")
    @score = 0
    @bonus_time = 0
    @display = Gosu::Font.new(28)
    @scene = :game
    @time_left = TIME_LIMIT
  end

  def draw
    if game_over?
      draw_end
    else
      draw_game
    end
  end

  def update
    if game_over?
      update_end
    else
      update_game
    end
  end

  private

  def game_over?
    (@scene == :end && @explosions.empty?) || @time_left < 0
  end

  def draw_game
    @background.draw(0, 0, 0)
    @racer.draw
    @opponents.each do |opponent|
      opponent.draw
    end

    @fuel_pellets.each do |pellet|
      pellet.draw
    end

    @explosions.each do |explosion|
      explosion.draw
    end

    @display.draw(@score, 10, 550, 1, 1, 1, Gosu::Color::AQUA)
    @display.draw(@time_left, 10, 20, 1, 1, 1, Gosu::Color::AQUA)
  end

  def update_game
    time_to_add = 0
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
        @passing_sound.play
      end

      if collision?(opponent, @racer)
        @explosions.push Explosion.new(self, opponent)
        @explosions.push Explosion.new(self, @racer)
        @explosion_sound.play
        @scene = :end
      end
    end

    @opponents.dup.each do |opponent|
      if opponent.y > HEIGHT + opponent.radius
        @opponents.delete opponent
      end
    end

    @explosions.each do |explosion|
      @explosions.delete explosion if explosion.finished
    end

    if rand < FUEL_FREQUENCY && @fuel_pellets.empty?
      @fuel_pellets.push FuelPellet.new(self)
    end

    @fuel_pellets.each do |pellet|
      pellet.move

      if collision?(pellet, @racer)
        @fuelup_sound.play(0.3)
        @fuel_pellets.delete pellet
        @bonus_time += 10
      end
    end

    @fuel_pellets.dup.each do |pellet|
      if pellet.y > HEIGHT
        @fuel_pellets.delete pellet
      end
    end

    @time_left = TIME_LIMIT - Gosu.milliseconds / 1000 + @bonus_time
  end

  def draw_end
    @background.draw(0, 0, 0)
    @game_over = Gosu::Font.new(32)
    @game_over.draw("Game Over", 10, 200, 3)
    @game_over.draw("Final Score:", 10, 250, 3)
    @game_over.draw("#{@score}", 10, 300, 3)
  end

  def update_end
    # NOOP
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

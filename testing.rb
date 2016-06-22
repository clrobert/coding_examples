class Game
  PLAYERS = %w{Paulina David Ian Leigh Mattie Brice Chris Shane Justin Luke}

  attr_reader :players, :it

  def initialize
    _setup
  end

  def play
    puts "#{it.name} is it!\n"
    sitting_players = (players - [it]).rotate(players.index(it))
    sitting_players.cycle.each do |player|
      if it.choose_goose?
        puts "#{player.name}: Goose!"
        @it = player
        break
      else
        puts "#{player.name}: Duck"
      end
    end
  end

  private

  def _setup
    @players = PLAYERS.map {|name| Player.new name: name}
    @it = @players.sample
  end
end

class Player
  attr_reader :name, :speed

  def initialize name: nil, speed: nil
    @name = name
    @speed = speed || (1..10).to_a.sample
  end

  def to_s
    name
  end

  def choose_goose?
    (1..20).to_a.sample >= 18
  end
end

game = Game.new
game.play


class Game
  def initialize
    names = ["Chris", "Shane", "Justin", "Luke", "Paulina", "David", "Ian", "Leigh", "Mattie", "Brice"]

    # To simulate people sitting down in a random arrangement.
    names = names.shuffle!

    circle = PlayerCircle.new

    names.each do |name|
      circle.add Player.new name
    end

    picker = circle.random_player

    5.times do |round|
      goose = picker.walk_circle circle.clone
      puts goose.name + " now chases " + picker.name + "!"
      picker_caught = goose.chase
      if !picker_caught      
        picker = goose 
        puts picker.name + " is now the picker!"
      end
    end

  end  
end

class PlayerCircle
  # @players = Array
  attr_accessor :players, :refresh

  def size
    @players.size
  end

  def refresh
    @players = @refresh
  end

  def empty
    @players.size == 0
  end

  def clone
    copy = PlayerCircle.new
    copy.players = Array.new @players
    copy 
  end

  def pop
    players.pop
  end

  def add
    @players.append player
    @refresh.append player
  end

  # Returns a random player from the list, no removal.
  def self.random_player 
    generator = Random.new
    random_number = generator.rand(@players.size) 
    @players[random_number]
  end
end

class Player
  attr_accessor :name, :active, :chosen_goose

  def initialize name
    @name = name
  end

  def chase
    # return random true or false
  end

  def dub player, chosen_goose, count, minimum_walk    
    if (player.name == chosen_goose.name) && (minimum_walk < count)
      label = "goose" 
    else
      label = "duck"
    end

    statement = player.name + " says " + label + " to " + player.name
  end

  def generate_minimum_walk circle
    generator = Random.new
    #range = circle.size / 2 .. circle.size * 2
    range = 10 # @fixme
    random_walk = generator.rand(range) 
  end

  def walk_circle circle
    chosen_goose = circle.random_player
    minimum_walk = generate_minimum_walk circle

    minimum_walk.times do |count|
      if !circle.empty
        dub circle.pop, chosen_goose, count, minimum_walk
      else
        circle.refresh
      end
    end
    goose
  end
end

class Duck < Player

end

class Goose < Player

end

Game.new

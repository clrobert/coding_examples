class Game
  attr_accessor :player_circle, :names, :picker

  # Setup the basic circle so the players can begin the game.
  def initialize names
    @names = names
    @names.shuffle!
    @player_circle = PlayerCircle.new @names

    @new_picker = @player_circle.select_random_player
    @player_circle.remove @new_picker
    @picker = Picker.new @new_picker.name

    Announce.new_picker @picker
  end

  # Play a round of the game.
  def play_round   
    @picker.save_circle @player_circle.clone

    goose = @picker.walk_circle

    # The goose comes out of the circle
    @player_circle.remove goose

    Announce.goose_chase goose, @picker

    picker_caught = goose.chase @picker

    if !picker_caught   
      # The old picker goes back into the circle   
      @player_circle.push @picker

      # The goose is the new picker
      @picker = Picker.new goose.name 

      Announce.new_picker @picker
    else
      # If the goose catches the picker, the goose goes back into the circle
       @player_circle.push goose
       Announce.old_picker @picker
    end
  end  
end

# Announces game events.
class Announce
  def self.goose_chase player_a, player_b
    puts player_a.name + " now chases " + player_b.name + "!"
  end

  def self.new_picker player
     puts player.name + " is now the picker!"
  end

  def self.old_picker player    
    puts player.name + " was caught! " + player.name + " is still the picker!"
  end
end

# Models both the actual player circle and the player's concept of a player circle.
class PlayerCircle
  attr_accessor :players, :roster

  def initialize names   
    @players = []
    @roster = []

    names.each do |name|
      @players.push Player.new(name)
      @roster.push Player.new(name)
    end
  end

  def self.reset
    @players = PlayerCircle.new(get_names(@roster.names))
  end

  def empty
    @players.empty?
  end

  def get_names players
    array = players.map { |player| player.name }
  end

  def clone
    copy = PlayerCircle.new(get_names(@players))
    copy 
  end

  def pop
    @players.pop
  end

  def remove player
    @players.delete player
  end

  def push player
    @players.push player
  end

  # Returns a random player from the list, no removal.
  def select_random_player
    random_number = (1..@players.size).to_a.sample 
    @players[random_number]
  end
end

class Player
  attr_accessor :name, :speed

  def initialize name
    @name = name
    @speed = (1..10).to_a.sample
  end
end

class Picker < Player
  attr_accessor :chosen_goose, :my_circle, :roster

  def save_circle circle    
    @my_circle = []

    chosen_goose = circle.select_random_player

    circle.players.each do |player|
      if player != chosen_goose
        @my_circle.push Duck.new player.name
      else
        @my_circle.push Goose.new player.name
      end
    end
    @roster = @my_circle
  end

  def reset
    @my_circle = Array.new @roster
  end  

  def is_this_the_goose? duck
    puts duck.name + " is a " + duck.quack  
    duck.can_chase  
  end

  def walk_circle
    found_goose = false
    goose = nil

    while !found_goose
      reset if @my_circle.empty?
      player = @my_circle.pop
      found_goose = is_this_the_goose? player
      goose = player if found_goose
    end

    goose
  end

end

class Duck < Player
  def self.quack
    self.class.to_s
  end

  def quack
    self.class.to_s
  end

  def can_chase
    false
  end
end

class Goose < Duck
  attr_accessor :faking_it

  # One out of four times, pretend the goose isn't the goose.
  def initialize name
    super
    @faking_it = [false, false, false, true].sample
  end

  def quack
    if faking_it
      Duck.quack
    else
      super
    end
  end

  def can_chase
    able = true unless faking_it

    # They should fake it at most one time.
    faking_it = false

    able
  end

  def chase picker
    @speed > picker.speed
  end
end

the_game = Game.new ["Chris", "Shane", "Justin", "Luke", "Paulina", "David", "Ian", "Leigh", "Mattie", "Brice"]

3.times do 
  the_game.play_round
end

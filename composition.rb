class Robot
  def initialize args
    @left_arm = args[0]
    @right_arm = args[1]
  end
end 

class RobotArm
  class InvalidAttributes < StandardError; end

  def initialize attributes
    @total = attributes.values
    @range = attributes[:range]
    @damage = attributes[:damage]
    @health = attributes[:health]
    @max_health = attributes[:max_health] 

    raise InvalidAttributes if !valid
  end

  def valid
    @total.reduce(:+) == 10
  end
end

class RobotArmaments
  def self.build type
    assemble(arm_ory[type])
  end

  def self.assemble specs
    attributes = {}
    attributes[:range] = specs[0]
    attributes[:damage] = specs[1]
    attributes[:health] = specs[2]
    attributes[:max_health] = specs[3]
    RobotArm.new attributes
  end

  def self.arm_ory
    {
      "stretch" =>[7,1,1,1],
      "strong" => [1,7,1,1],
      "tickle" => [1,1,3,4],
      "healthy" => [1,2,3,3],
      "defensive" => [2,2,3,3],
      "offensive" => [3,3,2,2],
      "crippled" => [1,1,1,7],
      "zombie" => [1,9,0,0],
      "ghost" => [9,1,0,0],
      "poke" => [4,4,1,1],
      "hook" => [5,3,1,1],
      "repair" => [5,-5,5,5],
      "blocking" => [0,0,5,5]
    }
  end
end

dumpster_parts = [RobotArmaments.build("stretch"), RobotArmaments.build("strong")]
bender = Robot.new dumpster_parts
puts bender.inspect

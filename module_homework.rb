module Prioritizable
  attr_accessor :priority
end

module Prioritizer

  @scheme = []

  def create_scheme list
    list.each_with_index |name, value|
      @scheme[name] = value 
    end
  end

  def compare object1, object2
    @scheme[object1.priority] <=> @scheme[object2.priority]
  end 

  def prioritize list

    list.each_with_index do |item, index|

      # yes, it's a one-pass bubble sort.
      if compare(item, list[index + 1]) < 0
        swap list, item, list[index + 1]
      end

    end

    list
  end
end


#
class Plane
  include Prioritizer
  attr_accessor :passengers

  priority_list = ["first class", "business class", "economy class", "pond scum class", "stowaway"]

  def initialize args
    
    # ...

    # hook
    create_scheme priority_list
  end
end

class Passenger
  include Prioritizable

    def initialize args
    
    # ...

    # hook
    set_priority args[:priority]
  end

end

class CPUScheduler
  include Prioritizer
  attr_accessor :process_list

  priority_list = ["time critical", "realtime", "high", "normal", "low", "idle", "zombie"]
end

class Process
  include Prioritizable
end

class Cruiseliner
  include Prioritizer
  attr_accessor :escape_boats

  priority_list = ["children", "women", "guys named Jack", "the band", "the captain"]
end

class EscapeBoat
  include Prioritizable
end



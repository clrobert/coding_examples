class MergeSort
  def self.sort input

    size = input.length
    divided = divide input, []

    while divided.length > 1 do
      divided = iterative_merge divided
    end

    divided.flatten
  end

  def self.divide in_list, out_list
    divide_point = in_list.length / 2
    if in_list.length > 1
      divide in_list.take(divide_point), out_list
      divide in_list.drop(divide_point), out_list
    else
      out_list.push(in_list)
    end
    out_list
  end

  def self.merge left_list, right_list
    list = []
    while !left_list.empty? and !right_list.empty? do
        if left_list && left_list.first <= right_list.first
          list.push left_list.shift
        else
          list.push right_list.shift
        end
    end

    while !left_list.empty? do
      list.push left_list.shift
    end

    while !right_list.empty? do
      list.push right_list.shift
    end

    list
  end

  def self.iterative_merge divided
    merged = []
    divided.each_with_index do |element, index|
      if index.even?
        sub_list = merge divided[index - 1], divided[index]
        merged.push(sub_list)
      end
    end
    merged
  end
end

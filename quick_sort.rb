class QuickSort
  def self.sort array
    if array.length <= 1
      return array
    end
    less = Array.new
    greater = Array.new
    pivot = array[array.length/2]
    array.each do |x|
      if x < pivot
        less << x
      elsif x > pivot
        greater << x
      end
    end
    return (sort(less) << pivot << sort(greater)).flatten.compact
  end

  def self.sort_inplace a, b, list
    new_pivot = partition a, b, list

    new_left_pivot = partition(1, new_pivot - 1, list)
    new_right_pivot = partition(new_pivot + 1, b, list)

    if list.take(new_left_pivot).length > 2
      sort(new_left_pivot, b, list)
    end

    if list.drop(new_right_pivot).length > 2
      sort(a, new_right_pivot, list)
    end # else partition directly the 2length list
    list.to_s
  end

  # a is the start index of the partition,
  # b is the end index of the partition
  def self.partition a, b, list
    pivot_value = list[b]
    current_pivot_index = b
    for i in (b).downto(a) do
      if list[i] > pivot_value
        value = list[i]
        list.insert(b + 1, value)
        list.delete_at i
        current_pivot_index = current_pivot_index - 1
      end
    end
    current_pivot_index
  end
end

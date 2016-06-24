class QuickSort

  # this is a crappy implementation
  # that does not beat merge sort.
  def self.duplicate_sort array
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

  def self.quick_sort list
    return list if list.uniq.size < 2
    p = list.sample
    left, right = list.partition{|elmt| elmt <= p}
    quick_sort(left) + quick_sort(right)
  end

  #def self.sort a, b, list
  #  pivot_index = b
  #  pivot_value = list[pivot_index]
#
  #  if a >= b
  #    return
  #  end
#
  #  for i in (b).downto(a) do
  #    if list[i] > pivot_value
  #      value = list[i]
  #      list.insert(pivot_index + 1, value)
  #      list.delete_at i
  #      pivot_index = pivot_index - 1
  #    end
  #  end
#
  #  if list.take(pivot_index).length > 1
  #    sort(a, pivot_index - 1, list)
  #  end
#
  #  if list.drop(pivot_index + 1).length > 1
  #    sort(pivot_index + 1, b, list)
  #  end
#
  #  list
  #end
end

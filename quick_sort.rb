class QuickSort
  def self.sort input
    output = recursive_pivot(input.length - 1, input, [])

    output
  end

  def self.recursive_pivot pivot, in_list, out_list
    in_list = pivot_push pivot, in_list

    if in_list.length > 2
      left_list = in_list.take(pivot)
      left_list = pivot_push(left_list.length - 1, in_list.take(pivot))
      recursive_pivot left_list.length - 1, left_list, out_list

      right_list = in_list.drop(pivot)
      right_list = pivot_push(right_list.length - 1, in_list.drop(pivot))
      recursive_pivot right_list.length - 1, right_list, out_list
    elsif in_list.length > 1
      out_list.push(pivot_push(1, in_list))
    else
      out_list.push in_list
    end
    out_list
  end

  def self.pivot_push pivot, list
    pivot_value = list[pivot]
    for i in (pivot).downto(0) do
      if list[i] > pivot_value
        list.push list[i]
        list.delete_at i
      end
    end
    list
  end
end

q = (1..100).to_a.shuffle.reverse
#QuickSort.pivot_push 1, [0,1]
#puts "==="
puts QuickSort.sort(q)



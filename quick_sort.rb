class QuickSort
# quicksort(A, 1, length(A))
#  algorithm quicksort(A, lo, hi) is
#    if lo < hi then
#        p := partition(A, lo, hi)
#        quicksort(A, lo, p – 1)
#        quicksort(A, p + 1, hi)
#algorithm partition(A, lo, hi) is
#    pivot := A[hi]
#    i := lo - 1        // place for swapping
#    for j := lo to hi – 1 do
#        if A[j] ≤ pivot then
#            i := i + 1
#            swap A[i] with A[j]
#    swap A[i + 1] with A[hi]
#    return i + 1


  def self.sort input
    output = recursive_pivot(input.length - 1, input, [])

    output
  end

  def self.recursive_pivot pivot, in_list, out_list
    in_list = pivot_push pivot, in_list

    left_list = in_list.take(pivot)
    left_list = pivot_push(left_list.length - 1, in_list.take(pivot))
    recursive_pivot left_list.length - 1, left_list, out_list

    right_list = in_list.drop(pivot + 1)
    right_list = pivot_push(right_list.length - 1, in_list.drop(pivot))
    recursive_pivot right_list.length - 1, right_list, out_list

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

A = [3,4,7,2,1,9,8,10].to_a.shuffle.reverse
#QuickSort.pivot_push 1, [0,1]
#puts "==="
puts QuickSort.sort(q)



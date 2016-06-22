class BubbleSort
  def self.sort input
    swap_happened = true
    while swap_happened do
      swap_happened = false
      input.each_with_index do |element, index|
        if (index < input.length - 1) && (input[index] > input[index + 1])
          temp = input[index]
          input[index] = input[index + 1]
          input[index + 1] = temp
          swap_happened = true
        end
      end
    end

    input
  end
end

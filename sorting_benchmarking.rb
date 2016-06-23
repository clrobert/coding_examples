require 'minitest/autorun'
require 'benchmark'
require_relative 'bubble_sort.rb'
require_relative 'merge_sort.rb'
require_relative 'quick_sort.rb'
require 'minitest/reporters'

reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

# @ Add:
# If the test runs longer than 30 seconds, kill it.
#

class SortingBenchmarking < Minitest::Test
  def setup
    #1k, 10k, 100k, 1mil
    @expos = [10**2, 10**3, 10**4, 10**5, 10**6, 10**6 * 2]
    @bs_expos = @expos.take(3)
  end

  def generate_list n
    (1..n).to_a.shuffle.reverse
  end

  def format_n n
    n.to_s.reverse.gsub(/...(?=.)/,'\&,').reverse
  end

  def test_bubble_sort
    puts "Bubble Sort:"
    @bs_expos.each do |expo|
      input = generate_list expo
      puts "Size: " + format_n(expo)
      puts Benchmark.measure { output = BubbleSort.sort input }
    end
  end

  def test_merge_sort
    puts "Merge Sort:"
    @expos.each do |expo|
      input = generate_list expo
      puts "Size: " + format_n(expo)
      puts Benchmark.measure { output = MergeSort.sort input }
    end
  end

  def test_quick_sort
    puts "Quick Sort:"
    @expos.each do |expo|
      input = generate_list expo
      puts "Size: " + format_n(expo)
      puts Benchmark.measure { output = QuickSort.sort input }
    end
  end

  def teardown
    puts ' '
  end
end

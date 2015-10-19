require 'benchmark'

puts "hi"

puts Benchmark.measure { "a"*1_000_000 }

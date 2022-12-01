input = File.read("day01_input.txt").split("\n\n").map {|l| l.split.map(&:to_i).sum }
p input.max
p input.sort[-3..-1].sum

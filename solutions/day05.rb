layout,moves = File.read("day05_input.txt").split("\n\n")

stacks = Array.new(layout.scan(/\d+/).last.to_i) {Array.new}
layout.lines.reverse.each {|l| l.scan(/[A-Z]/) {|c| stacks[($~.offset(0)[0])/4].push c } }
stacks2 = Marshal.load(Marshal.dump(stacks))
moves.lines.map {|l| l.scan(/\d+/).map(&:to_i) }.each do |move, from, to|
    stacks[to-1].push(*(stacks[from-1].slice!(-move, move).reverse))
    stacks2[to-1].push(*(stacks2[from-1].slice!(-move, move)))
end
p stacks.map {|s| s.last}.join
p stacks2.map {|s| s.last}.join

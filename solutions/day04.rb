input = File.read('day04_input.txt').lines.map {|l| l.scan(/\d+/).map(&:to_i) }
p input.map {|a| [(a[0]..a[1]), (a[2]..a[3])].permutation.any? {|a,b| a.cover? b } }.count(true)
p input.map {|a| a[0] > a[3] || a[1] < a[2] }.count(false)

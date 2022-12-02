input = File.read('day02_input.txt').lines.map {|l| l.strip.split }.map {|a,b| [a.ord-'A'.ord+1, b.ord-'X'.ord+1] }
p input.map { |a,b| 3*(((b+1)-a)%3) }.sum + input.map {|a,b| b }.sum
p input.map { |a,b| (a+b)%3+1 }.sum + input.map { |a,b| (b-1)*3 }.sum

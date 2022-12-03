input = File.read('day03_input.txt').lines.map(&:strip)

p input.map {|l| [l[..l.length/2-1], l[l.length/2..]] }
       .map {|a,b| (a.chars & b.chars).first.ord }
       .map {|c| (c >= 'a'.ord ? c - 'a'.ord+1 : c - 'A'.ord+27) }.sum

p input.map(&:chars).each_slice(3).to_a.map {|a,b,c| (a&b&c).first.ord }
       .map {|c| (c >= 'a'.ord ? c - 'a'.ord+1 : c - 'A'.ord+27) }.sum

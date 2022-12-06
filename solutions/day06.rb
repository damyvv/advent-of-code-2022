input = File.read('day06_input.txt').strip
p input.chars.each_cons(4).with_index.find {|s,i| s.uniq.count == 4 }[1]+4
p input.chars.each_cons(14).with_index.find {|s,i| s.uniq.count == 14 }[1]+14

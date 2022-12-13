packets = File.read("day13_input.txt").split("\n\n").map {|l| l.split.map {|a| eval a.strip } }

def cmp_arr(a,b)
    if !a.kind_of?(Array) && !b.kind_of?(Array)
        a <=> b
    else
        a = [a] unless a.kind_of?(Array)
        b = [b] unless b.kind_of?(Array)
        a.each_with_index do |ai,i|
            break if b[i].nil?
            cmp = cmp_arr(ai,b[i])
            return cmp unless cmp == 0
        end
        a.length - b.length
    end
end

p packets.map.with_index {|arr,i| arr.sort {|a,b| cmp_arr(a,b) } == arr ? i+1 : 0 }.sum
sorted = (packets + [[[[2]], [[6]]]]).flatten(1).sort {|a,b| cmp_arr(a,b) }
p (sorted.find_index([[2]])+1) * (sorted.find_index([[6]])+1)

input = File.read("day12_input.txt").lines.map {|l| l.strip.chars.map(&:ord) }
start = {}
target = {}
input.each_with_index do |r,y|
    r.each_with_index do |h,x| 
        if h == "S".ord
            start = {x: x, y: y}
            input[y][x] = "a".ord
        end
        if h == "E".ord
            target = {x: x, y: y} 
            input[y][x] = "z".ord
        end
    end
end

checked = []
to_check = [target]
moves = [[1,0], [0,1], [-1, 0], [0, -1]]

depth = 0
found_S = false
found_a = 0
while to_check.length > 0 && !found_S
    check_next = []
    to_check.each do |pos|
        height = input[pos[:y]][pos[:x]]
        moves.each do |x,y|
            to = {x: pos[:x] + x, y: pos[:y] + y}
            next if !to[:x].between?(0, input[0].length-1)
            next if !to[:y].between?(0, input.length-1)
            next if checked.include?(to)
            next if height > input[to[:y]][to[:x]]+1
            check_next.push to
            if "a".ord == input[to[:y]][to[:x]] && found_a == 0
                found_a = depth + 1
            end
            found_S = true if to == start
        end
    end
    checked.push(*to_check).uniq!
    to_check = check_next.uniq
    depth += 1
end
p depth
p found_a

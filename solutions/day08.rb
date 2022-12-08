grid = File.read("day08_input.txt").lines.map {|l| l.scan(/\d/).map(&:to_i) }
visible_cnt = 0
(1..grid.length-2).each do |r|
    (1..grid[0].length-2).each do |c|
        visible  = grid[r][..c-1].all? {|t| t < grid[r][c] }
        visible |= grid[r][c+1..].all? {|t| t < grid[r][c] }
        visible |= grid[..r-1].all? {|t| t[c] < grid[r][c] }
        visible |= grid[r+1..].all? {|t| t[c] < grid[r][c] }
        visible_cnt += 1 if visible
    end
end
p visible_cnt + (grid.length + grid[0].length-2)*2

max_score = 0
(1..grid.length-2).each do |r|
    (1..grid[0].length-2).each do |c|
        visible =   [grid[r][..c-1].reverse.map {|t| t < grid[r][c] }]
        visible.push grid[r][c+1..]        .map {|t| t < grid[r][c] }
        visible.push grid[..r-1].reverse.map {|t| t[c] < grid[r][c] }
        visible.push grid[r+1..]        .map {|t| t[c] < grid[r][c] }
        visible = visible.map {|v| (v.find_index {|b| !b} || v.length-1)+1 }
        max_score = [max_score, visible.inject(:*)].max
    end
end
p max_score

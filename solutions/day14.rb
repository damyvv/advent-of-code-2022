walls = File.read("day14_input.txt").lines.map {|l| l.scan(/(\d+),(\d+)/).map {|a| a.map(&:to_i) } }
cave1 = {}
walls.each do |conn|
    conn.each_cons(2) do |line|
        line.sort!
        (line[0][1]..line[1][1]).each do |y|
            (line[0][0]..line[1][0]).each do |x|
                cave1[{y: y, x: x}] = :rock
            end
        end
    end
end
cave2 = Marshal.load(Marshal.dump(cave1))

$floor = cave1.keys.map {|h| h[:y] }.max+1
def sand_fall(cave, sand_pos, part2)
    return nil if !part2 && sand_pos[:y] >= cave.keys.map {|h| h[:y] }.max
    return sand_pos if sand_pos[:y] >= $floor
    if    !cave.include?({y: sand_pos[:y]+1, x: sand_pos[:x]  })
        sand_fall(cave,  {y: sand_pos[:y]+1, x: sand_pos[:x]  }, part2)
    elsif !cave.include?({y: sand_pos[:y]+1, x: sand_pos[:x]-1})
        sand_fall(cave,  {y: sand_pos[:y]+1, x: sand_pos[:x]-1}, part2)
    elsif !cave.include?({y: sand_pos[:y]+1, x: sand_pos[:x]+1})
        sand_fall(cave,  {y: sand_pos[:y]+1, x: sand_pos[:x]+1}, part2)
    else
        sand_pos
    end
end

part2 = false
loop do
    cave = part2 ? cave2 : cave1
    fall_pos = {y: 0, x: 500}
    new_sand = sand_fall(cave,fall_pos,part2)
    if new_sand.nil?
        part2 = true
        next
    end
    cave[new_sand] = :sand
    break if new_sand == fall_pos
end

p cave1.values.count(:sand)
p cave2.values.count(:sand)

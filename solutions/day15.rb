sensors = File.read("day15_input.txt").lines.map {|l| l.scan(/[-\d]+/).map(&:to_i) }
    .map {|sx,sy,bx,by| {{x: sx, y: sy} => {b: {x: bx, y: by}, d: (sx-bx).abs+(sy-by).abs}} }.reduce({}, :merge)

def get_coverage(sensors,y)
    puts "#{100*(y/4000000.0)}%" if y % 10000 == 0
    covered = []
    sensors.each do |s,v|
        rem_x = v[:d]-(s[:y]-y).abs
        next unless rem_x > 0
        covered.push [s[:x]-rem_x,s[:x]+rem_x]
    end
    covered.sort!
    covered.each_with_index do |a,i|
        next if a[0] == a[1] && a[1] == 0
        covered.each_with_index do |b,j|
            next unless j > i
            if a[1] > b[1]
                b[0] = b[1] = 0
            elsif a[1]+1 >= b[0]
                a[1] = [a[1],b[1]].max
                b[0] = b[1] = 0
            end
        end
    end
    covered.filter {|a| !(a[0] == a[1] && a[0] == 0) }
end

solution_b = [0,0]
(0..4000000).each do |y|
    res = get_coverage(sensors, y)
    if res.length > 1
        solution_b = [res[0][1]+1, y]
    end
end
p get_coverage(sensors, 2000000).map {|lx,rx| (lx-rx).abs}.sum
p solution_b[0]*4000000+solution_b[1]

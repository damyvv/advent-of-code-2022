moves = File.read('day09_input.txt').scan(/(\w)\s(\d+)/).map {|d,i| [d, i.to_i]}
$rope = Array.new(10) { {x:0,y:0} }
pos_l1 = []
pos_l9 = []

def move_head(dir)
    case dir
    when "R" then $rope[0][:x] += 1
    when "L" then $rope[0][:x] -= 1
    when "U" then $rope[0][:y] += 1
    when "D" then $rope[0][:y] -= 1
    end
end

def normalize_tail(i)
    dist = {:x => ($rope[i-1][:x] - $rope[i][:x]), :y => ($rope[i-1][:y] - $rope[i][:y])}
    len = (dist[:x].abs+dist[:y].abs).to_f
    return if len == 0
    dist[:x] = (dist[:x] / len).round
    dist[:y] = (dist[:y] / len).round
    $rope[i] = {x: $rope[i-1][:x] - dist[:x], y: $rope[i-1][:y] - dist[:y]}
end

moves.each do |dir, dist|
    dist.times do
        move_head(dir)
        9.times { |i| normalize_tail(i+1) }
        pos_l1.push $rope[1]
        pos_l9.push $rope[9]
    end
end

p pos_l1.uniq.length
p pos_l9.uniq.length

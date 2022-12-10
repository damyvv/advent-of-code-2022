instl = File.read("day10_input.txt").lines.map {|l| l.scan(/\S+/) }
reg_x = 1
$cycle = 0
$strengths = 0
$crt = ""

def cycle_step(x)
    $cycle += 1
    $strengths += $cycle*x if ($cycle-20) % 40 == 0
    crt_x = ($cycle-1) % 40
    $crt += "\n" if crt_x == 0
    $crt += ((crt_x - x).abs <= 1 ? "█" : " ")
end

instl.each do |inst|
    case inst[0]
    when "noop"
        1.times { cycle_step(reg_x) }
    when "addx"
        2.times { cycle_step(reg_x) }
        reg_x += inst[1].to_i
    end
end

puts $strengths
puts $crt

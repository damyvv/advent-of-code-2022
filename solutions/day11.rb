input = File.read("day11_input.txt").split("\n\n").map {|l| l.lines[1..].map(&:strip) }
monkeys = input.map do |line|
    monkey = {}
    monkey[:items_p1] = line[0].scan(/\d+/).map(&:to_i)
    monkey[:items_p2] = line[0].scan(/\d+/).map(&:to_i)
    monkey[:op] = line[1].scan(/=(.*)/)[0][0].strip
    monkey[:div] = line[2].scan(/\d+/).first.to_i
    monkey[:true] = line[3].scan(/\d+/).first.to_i
    monkey[:false] = line[4].scan(/\d+/).first.to_i
    monkey[:inspected_p1] = 0
    monkey[:inspected_p2] = 0
    monkey
end

def eval_monkey_op(old, op)
    return eval op
end

mod = monkeys.map {|m| m[:div]}.inject(1) {|mod, n| mod.lcm(n) }
rounds = 10000
rounds.times do |round|
    monkeys.each do |monkey|
        if round < 20
            monkey[:items_p1].each_with_index do |item, idx|
                worry = eval_monkey_op(item, monkey[:op]) / 3
                monkeys[monkey[(worry % monkey[:div] == 0).to_s.to_sym]][:items_p1].push(worry)
                monkey[:inspected_p1] += 1
            end
            monkey[:items_p1] = []
        end
        monkey[:items_p2].each_with_index do |item, idx|
            worry = eval_monkey_op(item, monkey[:op]) % mod
            monkeys[monkey[(worry % monkey[:div] == 0).to_s.to_sym]][:items_p2].push(worry)
            monkey[:inspected_p2] += 1
        end
        monkey[:items_p2] = []
    end
end

p monkeys.map {|m| m[:inspected_p1]}.sort[-2..].reduce(:*)
p monkeys.map {|m| m[:inspected_p2]}.sort[-2..].reduce(:*)

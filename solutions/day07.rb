input = File.read('day07_input.txt').lines.map {|l| l.scan(/\S+/) }
$dir = []
current_dir = nil
i = 0

def add_size(size, base)
    return if base.nil?
    $dir[base][:size] += size
    add_size(size, $dir[base][:parent])
end

loop do
    break if i >= input.length
    case input[i][0]
    when '$'
        if input[i][1] == "cd"
            new_dir = input[i][2]
            case new_dir
            when ".."
                current_dir = $dir[current_dir][:parent]
            else
                $dir.push({name: new_dir, parent: current_dir, children: [], size: 0 })
                $dir[current_dir][:children].push new_dir if !current_dir.nil?
                current_dir = $dir.length-1
            end
        end
    else
        add_size(input[i][0].to_i, current_dir) if input[i][0] != "dir"
    end
    i += 1
end

p $dir.map {|d| d[:size] }.filter {|s| s <= 100000 }.sum

disk_size = 70000000
required_size = 30000000
free = required_size - (disk_size - $dir[0][:size])
p $dir.map {|d| d[:size] }.filter {|s| s >= free }.min

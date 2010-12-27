require 'mathn'

nums = []
File.open("p099_base_exp.txt") do |file|
  i = 1
  while line = file.gets
    base, exp = line.chomp.split(',')
    scale = (Math.log(base.to_i)*exp.to_i).ceil
    nums << [scale, i, base, exp]
    i+=1
  end
end

p nums.sort.last

require 'date'

n = 0
1901.upto 2000 do |year|
  1.upto 12 do |month|
    n += 1 if Date.parse("#{year}/#{month}/01").wday == 0
  end
end

puts n

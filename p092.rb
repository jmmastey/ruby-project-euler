require 'tools'

ones = {}
eightynines = {}

def sd n
  n.to_s.split(//).inject(0) { |sum,s| sum + (s.to_i**2) }
end

n = 0
lim = 1e7
1.upto lim do |i|
  puts "#{i}: #{n}" if 0 == i % 10000

  perms = []

  while true
    if i == 1 || ones.include?(i)
      ones.addkeys perms
      break
    end

    if i == 89 || eightynines.include?(i)
      eightynines.addkeys perms
      n += 1
      break
    end

    i = sd i
    perms << i
  end
end

p n



fibct = 4
a = 3
b = 2

while true
  fibct += 1
  a, b = (a+b), a

  if a.to_s.length == 1000
    puts "#{fibct}: #{a}"
    exit
  end
end

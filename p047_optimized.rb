require 'mathn'

i = 1
loop do
  if (i+3).prime_division.length != 4
    i += 4
    next
  end

  if (i+2).prime_division.length != 4
    i += 3
    next
  end

  if (i+1).prime_division.length != 4
    i += 2
    next
  end

  if (i).prime_division.length != 4
    i += 1
    next
  end

  puts i
  exit
end

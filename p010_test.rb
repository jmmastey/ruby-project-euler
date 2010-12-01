max = 2000
series = (2..max).to_a
sum = 0

while series.length > 0
  candidate = series[0]
  sum += candidate

  wipe = candidate

  while series.length && wipe <= series.last
    series.delete wipe
    wipe += candidate

    break unless 0 < series.length
  end
end


puts "the sum of primes for #{max} is #{sum}"

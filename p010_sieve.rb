max = 2000000
series = (2..max).to_a
sum = 0

sqrt = Math.sqrt(max).ceil


0.upto series.length do |k|
  next unless series[k]

  candidate = series[k]
  sum += candidate

  if candidate <= sqrt
    wipe = (candidate**2)-2 # abuse indices. arr[n] = n+2
    while wipe <= max
      series[wipe] = nil
      wipe += candidate
    end
  end
end


puts "the sum of primes for #{max} is #{sum}"

def rotate str
  "#{str[-1,1]}#{str[0..-2]}"
end

def get_rotations(num, primes)
  orig_str = num.to_s
  str = rotate orig_str
  pr = [num]

  while str != orig_str
    pr << str.to_i
    return [] unless primes.include? str.to_i
    str = rotate str
  end

  pr
end

max = 1000000
series = (2..max).to_a
circs = []

sqrt = Math.sqrt(max).ceil
0.upto series.length do |k|
  next unless series[k]

  candidate = series[k]

  if candidate <= sqrt
    wipe = (candidate**2)-2 # abuse indices. arr[n] = n+2
    while wipe <= max
      series[wipe] = nil
      wipe += candidate
    end
  end

  # numbers w/ any evens (other than 2) will never be circular
  series[k] = nil if candidate > 2 && candidate.to_s.match(/[24680]/)
end

series = series.compact
series.each do |pr|
  next if circs.include? pr
  circs += get_rotations(pr, series)
end

sum = 0
circs.each { |cpr| puts cpr; sum += cpr; }
puts "for i < #{max}, sum is #{sum}, ct is #{circs.length}"

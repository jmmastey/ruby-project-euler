

def truncatable?(n, primes)
  return false if n < 10

  s = n.to_s
  while s.length > 1 do
    s = s[0..-2]
    return false unless primes.include? s.to_i
  end

  s = n.to_s
  while s.length > 1 do
    s = s[1..-1]
    return false unless primes.include? s.to_i
  end

  return true
end

max = 1000000
series = (2..max).to_a
truncs = []

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
  series[k] = nil if candidate > 23 && candidate.to_s.match(/[24680]/)
end

series = series.compact
series.each { |pr| truncs << pr if truncatable?(pr, series) }

sum = 0
truncs.each { |cpr| puts cpr; sum += cpr; }
puts "for i < #{max}, sum is #{sum}, ct is #{truncs.length}"


class Fixnum
  def prime?
    ('1' * self.to_i) !~ /^1?$|^(11+?)\1+$/
  end
end

max = 1000000
series = (2..max).to_a

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
end

def is_circular? num

end




puts "the sum of primes for #{max} is #{sum}"

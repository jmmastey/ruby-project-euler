
class Fixnum

  def prime? previous_primes
    previous_primes.each do |p|
      return false if 0 == self.to_i%p
    end

    return true
  end

end

p_num = 6
p_max = 10001
curr = 13
primes = [3,5,7,11]

while p_num <= p_max
  curr += 2
  if curr.prime?(primes)
    p_num += 1
    primes << curr
  end
end

puts "#{p_max}st prime is #{curr}"


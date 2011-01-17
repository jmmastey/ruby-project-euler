

def d n
  divisors = [1]
  2.upto(n**0.5) do |i|
    if 0 == n%i
      divisors << i
      divisors << n/i
    end
  end

  divisors.inject(0){|sum,i| sum += i}
end


rangemax = 10000
friends = {}
rangemax.downto 2 do |i|
  next if friends.include? i

  friend = d i
  if i != friend && i == d(friend)
    friends[i] = friend
    friends[friend] = i
  end
end

#p friends
p friends.keys.inject(0){|sum,i| sum += i}

# i don't understand why this generates the fractions properly, but (n+1) = 2(n)+(n-1)
# for both the num and denom. and quickly, too!

denoms = [2,5,12]
nums = [3,7,17]
1.upto 997 do |i|
  denoms << (denoms[-1]+denoms[-2]) + denoms[-1]
  nums << (nums[-1]+nums[-2]) + nums[-1]
end

ct = 0
0.upto denoms.length-1 do |i|
  if nums[i].to_s.length > denoms[i].to_s.length
    p "#{nums[i]}/#{denoms[i]}"
    ct += 1
  end
end

puts ct

require 'tools'

def add_number(nums, type, n)
  t = (yield n).to_s

  return unless t.length == 4
  nums[t[0,2]] ||= []
  nums[t[0,2]] << [type,t]
end

nums = {}
types = [ :triangle, :square, :pentagon, :hexagon, :heptagon, :octagon ]
20.upto 1000 do |n|
  add_number(nums, :triangle, n) { |n| MathUtils.triangle n }
  add_number(nums, :square, n) { |n| MathUtils.square n }
  add_number(nums, :pentagon, n) { |n| MathUtils.pentagon n }
  add_number(nums, :hexagon, n) { |n| MathUtils.hexagon n }
  add_number(nums, :heptagon, n) { |n| MathUtils.heptagon n }
  add_number(nums, :octagon, n) { |n| MathUtils.octagon n }
end

def solve(arr, curr, solution, types_needed)
  if 0 == types_needed.length
    # completely cyclical
    return unless solution.first[1][0,2] == solution.last[1][2,4] 

    p solution
    p solution.inject(0) { |sum,a| sum + a[1].to_i }
    exit
  end

  newkey = curr[2,4]
  return unless arr.include? newkey

  arr[newkey].each do |type, num|
    next unless types_needed.include? type
    solve(arr, num, (solution.clone + [[type,num]]), (types_needed.clone - [type]))
  end
end

nums.each do |key, pairs|
  pairs.each do |type, num|
    solve(nums, num, [[type,num]], (types.clone - [type]))
  end
end

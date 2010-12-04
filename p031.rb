def get_currency(stack, currencies, i, target, ans)
  return unless i < currencies.length

  curr = currencies[i]

  if 1 == curr
    nans = ans + ["#{target}x1"]
    stack << nans
    return
  end


  iters = target/curr
  0.upto iters do |j|
    taken = j*curr
    nans = ans + ["#{j}x#{curr}"]

    if taken == target
      stack << nans
      return
    end

    get_currency(stack, currencies, (i+1), (target-taken), nans)
  end
end

currencies = [1,2,5,10,20,50,100,200].reverse
target = 200
stack = []

get_currency(stack, currencies, 0, target, [])
stack[-200..-100].each { |r| puts r.join " " }
puts "Total ct: #{stack.length}"

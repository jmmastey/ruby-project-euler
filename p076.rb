
def parts n
  if @cache.include? n
    p "cache hit #{n}"
    return @cache[n]
  end

  c = [[n]]
  1.upto n-1 do |i|
    cs = parts(n-i)
    cs.each do |cmb|
      c << (cmb + [i])
    end
  end

  (@cache[n] = c)
end

@cache = { 1 => [[1]] }
@ans = {}

st = 50
1.upto st-1 do |n|
  p n
  c = parts n
  c.each do |l|
    exp = ((l + [n]).sort.join ",")
    @ans[exp] = nil
  end
end

p @ans.length

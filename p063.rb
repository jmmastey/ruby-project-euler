pows = []
lim = 40

# turns out we could have saved .008s by setting the lim lower :)

1.upto lim do |i|
  1.upto lim do |j|
    p = i**j
    l = p.to_s.length

    pows << [p, j, i] if l == j
  end
end

p pows
p pows.length

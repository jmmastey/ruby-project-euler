require 'tools'

d = []
10.upto 99 do |i|
  10.upto 99 do |j|
    next unless MathUtils.coprime?(i,j)
    next unless i.to_s[1] == j.to_s[0]
    next unless i != j

    long = "#{i}/#{j}"

    div = (i.factors & j.factors).sort.last
    i1 = i/div
    j1 = j/div
    short = "#{i1}/#{j1}"
    next unless short == long[0,1]+long[2,1]+long[4,1]

    d << "#{i}/#{j} (#{i1}/#{j1})"
  end
end

puts d

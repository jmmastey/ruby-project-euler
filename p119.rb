def digital_sum n
  n.to_s.split(//).inject(0) { |sum,s| sum + s.to_i }
end

sols = []

1.upto 100 do |base|
  1.upto 15 do |exp|
    n = base**exp
    next unless n > 10
    next unless digital_sum(n) == base
    #p [n, base, exp]
    sols << [n, base, exp]
  end
end

#sols.sort.each { |s| p s }
p sols.sort[29][0]

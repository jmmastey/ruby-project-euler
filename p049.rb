class Fixnum
  def prime?
    ('1' * self.to_i) !~ /^1?$|^(11+?)\1+$/
  end
end

perms = {}

1000.upto 9999 do |k|
  next unless k.prime?
  canonical = k.to_s.split(//).sort.join('')

  perms[canonical] ||= []
  perms[canonical] << k
end

perms = perms.select { |k,v| v.length >= 3 }

perms.each do |k,v|
  diffs = {}
  prev = 0
  v.each do |curr|
    diffs.each do |d,dv|
      last = dv.last
      diff = curr-last
      diffs[d] << curr if diff == d
    end

    diff = curr-prev
    if !diffs.include? diff
      diffs[diff] = [prev,curr]
    end

    prev = curr
  end

  diffs.each do |k,v|
    next unless v.length >= 3

    print "#{k} "
    p v
  end
end

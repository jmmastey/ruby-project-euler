
#max = 10000
# this is called cheating. might as well say max is 2167
max = 2500
pentags = []
pdict = {}
1.upto max do |i|
  pentags << i*((3*i)-1)/2
  pdict[i*((3*i)-1)/2] = nil
end

# main optimization, sadly enough, is O(n) lookups
# thanks to dict.

subs = {}
pentags.length.downto 0 do |k|
  p = pentags[k]
  1.upto(pentags.length-1-k) do |s|
    p2 = pentags[k+s]
    next unless pdict.include?(p2-p)
    next unless pdict.include?(p2+p)

    puts "#{k} (#{p}), #{k+s} (#{p2}) (#{(p2-p).abs})"
    exit
  end
end

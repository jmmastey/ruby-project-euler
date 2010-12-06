
tnums = []
1.upto 10000 do |i|
  tnums << (0.5*i*(i+1)).to_i
end

words = File.read("p042_words.txt").gsub('"', "").split(",")
twords = []

words.each do |word|
  sum = word.bytes.inject(0) { |sum,cb| sum += cb-64 }
  twords << [word,sum] if tnums.include? sum
end

twords.each { |w| puts " #{w[0]}: #{w[1]}" }
puts twords.length

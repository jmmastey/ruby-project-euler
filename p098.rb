idx = {}
words = File.read("p098_words.txt").gsub(/"/,'').split(",")
words.each do |word|
  handle = word.split(//).sort.join

  idx[handle] ||= []
  idx[handle] << [word]
end

pallindromes = idx.select { |k,v| v.length >= 2 }
p pallindromes.length

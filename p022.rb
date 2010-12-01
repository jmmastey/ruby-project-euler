names = File.read("names.txt").gsub(/"/, "").split(",")
names.sort!

def score_name(name, rank)
  score = name.split(//).inject(0){|sum,c| sum += (c[0]-64)}
  place = rank+1

  score*place
end

scoresum = 0
names.each_with_index do |name,rank|
  scoresum += score_name(name, rank)
end

puts "sum of all names: #{scoresum}"

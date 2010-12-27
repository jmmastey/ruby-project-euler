require 'dijkstra'

cnt = File.read("p082_matrix.txt")
graph = []
lines = cnt.split(/\n/)

0.upto lines.length-1 do |i|
  line = lines[i]
  cells = line.split(',')
  graph[i] = []

  0.upto cells.length-1 do |j|
    cost = cells[j].to_i
    n = Node.new(cost)
    graph[i][j] = n

    graph[i-1][j].connect n if i > 0
    n.connect graph[i-1][j] if i > 0

    graph[i][j-1].connect n if j > 0
  end
end

dests = graph.inject({}){|a,row| a[row[79]] = nil; a }
sols = []
max = 1_000_000
graph.each do |row|
  root = row[0]
  root.dist = root.cost

  puts "Calculating for #{root}"
  path = root.calc_path_to(dests,max)

  if path.nil?
    puts "Gave up on #{root}"
    next
  end

  sols << [path.first.dist, path.length, path.first, path.last]
  max = [max,path.first.dist].min
  puts "Got #{path.first.dist}"
end

(sols.sort_by { |n1,n2| n1[0] <=> n2[0] }).each do |sol|
  puts "#{sol[0]} in #{sol[1]} moves"
end

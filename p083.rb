require 'dijkstra'

cnt = File.read("p083_matrix.txt")
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
    n.connect graph[i][j-1] if j > 0
  end
end

root = graph[0][0]
root.dist = root.cost

dest = graph[79][79]
path = root.calc_path_to dest
a = path.inject([]) { |a,n| a << n.cost }
puts a.join " <= "
puts "#{a.length} links in the solution"
puts path.first.dist


class Node
  attr_accessor :connected, :dist, :cost, :prior, :visited

  def initialize(cost)
    @cost = cost
    @visited = false
    @connected = []
  end

  def <=>(other)
    (@dist || 1_000_000) <=> (other.dist || 1_000_000)
  end

  def connect node
    @connected << node
  end

  def calc_path_to(node, giveup = 1_000_000)
    case node.class.to_s
      when 'Node'
        comp = lambda { |tgt| node == tgt }
      when 'Array'
        comp = lambda { |tgt| node.include? tgt }
      when 'Hash'
        comp = lambda { |tgt| node.include? tgt }
      else
        raise "Illegal target #{node.class}"
    end

    process
    arr = @connected.sort

    found = false
    while arr.length > 0
      closest = arr[0]
      arr.delete closest

      next unless closest.prior = self
      if comp.call(closest)
        found = true
        break
      end
      break if closest.dist >= giveup

      closest.process
      arr += closest.connected.select { |n| !n.visited }
      arr.sort!
      #puts "arr has #{arr.length}"
    end

    return nil unless found
    closest.path_from self
  end

  def process
    #puts "considering #{self}"

    @visited = true
    @connected.each { |node| process_neighbor node }
  end

  def process_neighbor neighbor
    s = @dist + neighbor.cost
    return if neighbor.dist && neighbor.dist < s

    neighbor.dist = s
    neighbor.prior = self
    neighbor.visited = false
  end
  protected :process_neighbor

  def path_from node
    path = [self]
    return path if self == node

    prior = @prior
    while prior != node
      raise "Never gets back to #{node}" unless prior.prior
      path << prior
      prior = prior.prior
    end

    (path << prior)
  end

  def reset
    @dist = nil
    @prior = nil
    @visited = false
    @connected.each { |n| n.reset if n.visited }
  end

  def to_s
    conn = @connected.inject([]) { |s,n| s << n.cost }
    "#{@cost}/#{@dist} (#{conn.join ','})"
  end
end


class String
  def pallindrome?
    self.reverse == self
  end
end

lychrels = []

1.upto 10000 do |i|
  iteration = 0
  s = i.to_s
  #intermediates = [s]

  while true
    s = (s.to_i + s.reverse.to_i).to_s
    iteration += 1

    # not a lychrel
    if s.pallindrome?
      # this "optimization" actually will increase the running time by several orders of magnitude
      #if s.pallindrome? || nonlychrels.include?(s)
      #puts "#{orig_s} solved at #{s} (in #{iteration} iterations)"
      #intermediates.each do |ns|
      #  nonlychrels << ns #unless nonlychrels.include? ns
      #end

      break
    end

    #intermediates << s

    # we know this is a lychrel
    if iteration == 50
      lychrels << i.to_s
      break
    end
  end
end

p lychrels
p lychrels.length

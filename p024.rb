# to grab the next permutation, we effectively need to find the next larger number.
# flip all less significant digits before flipping a more significant digit

# 012345 6789
# 012345 6798
# 012345 6879
# 012345 6897
# 012345 6978
# 012345 6987

# 012345 7689
# 012345 7698
# 012345 7869
# 012345 7896
# 012345 7968
# 012345 7986

# 012345 8679
# 012345 8697
# 012345 8769
# 012345 8796
# 012345 8967
# 012345 8976

# 012345 9678
# 012345 9687
# 012345 9768
# 012345 9786
# 012345 9867
# 012345 9876

class Array

  def rsorted?
    return true if 1 == self.length
    return self[0] >= self[1] if 2 == self.length
    self == self.sort.reverse
  end

  def swap!(val1, val2)
    i1 = self.index val1
    i2 = self.index val2

    return if (i1.nil? or i2.nil?)
    self[i1], self[i2] = self[i2], self[i1]
  end

end

class Permuter
  attr_accessor :seq, :rseq, :len

  def initialize seq
    @seq = seq
    @rseq = seq.reverse
    @len = seq.length
  end

  def permute!
    @len.downto 0 do |i|
      chunk = @seq[i..-1]
      next if chunk.rsorted?

      nint = chunk.select { |k| k > chunk[0] }.min
      @seq.swap! chunk[0], nint
      @seq[(i+1)..-1] = @seq[(i+1)..-1].reverse
      return self
    end

    raise 'The set is already permuted to its maximum state'
  end

  def to_s
    return @seq.join ""
  end

end

p = Permuter.new([0,1,2,3,4,5,6,7,8,9])
1.upto 999999 do
  p.permute!
end

puts p

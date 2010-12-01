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

  def sorted?
    return true if self.length <= 1
    return self[0] - self[1] if self.length == 2


  end

end

def permute seq

end

seq = [0,1,2,3,4,5,6,7,8,9]

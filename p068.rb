require 'tools'

def solution_range size
end

def solve_for sol
  ring = { :score => sol, :lines => [], :digits => @digits.clone }
  @size.times { ring[:lines] << Array.new(3,nil) }
  solve ring
end

def solve ring
  def mark(ring,line,idx,num)
    # deep clone
    r = Marshal.load(Marshal.dump(ring))
    r[:lines][line][idx] = num
    r[:lines][(line-1) % @size][2] = num if idx == 1
    r[:lines][(line+1) % @size][1] = num if idx == 2
    r[:digits].delete num
    r
  end

  def sub_in(ring,l,idx,nums)
    nums.inject([]) { |sols,d| sols + solve(mark(ring,l,idx,d)) }
  end

  0.upto ring[:lines].length-1 do |l|
    line = ring[:lines][l]
    next unless line.include? nil
    idx = line.index nil

    if 0 == idx
      candidates = l == 0 ? ring[:digits] : ring[:digits].select { |x| x > ring[:lines][0][0] }
      return sub_in(ring,l,0,candidates)
    elsif 1 == idx
      max = ring[:score] - line[0]
      digits = ring[:digits].select { |n| n < max }
      return sub_in(ring,l,1,digits)
    else
      last = ring[:score] - line.sum
      return [] unless ring[:digits].include? last
      return sub_in(ring,l,2,[last])
    end
  end

  # all triplets add properly
  return [] if ring[:lines].last.sum != ring[:score]

  # win!
  ring[:sum] = (ring[:lines].inject("") { |s,l| s + l.join('') }).to_i
  ring.delete :digits
  return [ring]
end


@size = 5
@digits = (1..@size*2).to_a

min = (@digits[0..@size-1].sum * 2 + @digits[@size..-1].sum)/@size
max = (@digits[@size..-1].sum * 2 + @digits[0..@size-1].sum)/@size

sols = (min..max).inject([]) { |sols,n| sols + solve_for(n) }
sols = (sols.sort_by { |s| s[:sum] }).reverse
sols.each { |s| puts s }

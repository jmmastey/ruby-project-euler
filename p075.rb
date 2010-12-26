require 'tools'

# http://www.grc.nasa.gov/WWW/k-12/Numbers/Math/Mathematical_Thinking/pythtrip.htm
# euclid's formula
# for u**2 > v**2
#a = lambda { |u,v| 2*u*v }
#b = lambda { |u,v| u**2 - v**2 }
#c = lambda { |u,v| u**2 + v**2 }

lim = 1_500_000
tris = {}
alltris = {}
sum = 0
2.upto lim do |u|
  1.upto u-1 do |v|
    a = u**2 - v**2
    b = 2*u*v
    c = u**2 + v**2

    bs = a + b + c
    break if bs > lim
    next if a+b % 2 == 0 && 1 == a.gcd(b)

    1.upto(lim/bs) do |k|
      ak = a*k
      bk = b*k
      ck = c*k
      triple = [ak,bk,ck]
      s = triple.sum

      triple_s = triple.sort.join ','
      next if alltris.include? triple_s
      alltris[triple_s] = nil

      tris[s] ||= 0
      tris[s] += 1

      case tris[s]
        when 1:
          sum += 1
        when 2:
          sum -= 1
      end
    end #k
  end #v
end #u

p sum


# 333082500

@pows = {}
def getpow(n,pow)
  (@pows["#{n}:#{pow}"] ||= n**pow)
end

maxsum = 0
3.upto 1000 do |a|
  asq = getpow(a,2)
  max = 0
  1.upto a*2 do |n|
    s = getpow(a-1,n) + getpow(a+1,n)
    max = [s % asq,max].max
  end
  puts "#{max} for #{a} : #{2*a*((a-1)/2)}" if max !=  2*a*((a-1)/2)
  maxsum += max
end

p maxsum

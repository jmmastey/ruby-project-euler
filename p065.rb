require 'mathn'

fracs = [ 2, 3, 8/3, 11/4, 19/7 ]
n = 5

2.upto 33 do |k|
  kmult = 2*k
  num = fracs[n-1].numerator*kmult + fracs[n-2].numerator
  dem = fracs[n-1].denominator*kmult + fracs[n-2].denominator
  fracs << num/dem
  n+=1

  num = fracs[n-1].numerator + fracs[n-2].numerator
  dem = fracs[n-1].denominator + fracs[n-2].denominator
  fracs << num/dem
  n+=1

  num = fracs[n-1].numerator + fracs[n-2].numerator
  dem = fracs[n-1].denominator + fracs[n-2].denominator
  fracs << num/dem
  n+=1
end

p fracs[99]
p fracs[99].numerator.to_s.split(//).inject(0) { |sum,s| sum + s.to_i }

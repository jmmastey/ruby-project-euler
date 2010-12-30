def get_digits(s, i)
  return "00" if i >= s.length
  return s[-1,1]+"0" if i == s.length-1
  return s[i,i+2]
end

1.upto 100 do |n|
  s = n.to_s
  a = ""
  if s.length.even?
    pdig = s[0,2].to_i
    i = 2
  else
    pdig = s[0,1].to_i
    i = 1
  end

  whole = (pdig**0.5).floor
  r = pdig-whole**2
  a += "#{whole}."

  if r == 0
    # perfect square
    next
  end



end

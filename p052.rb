
def digits i
  i.to_s.split(//).sort.join('')
end

i = 20000
while true
  num = ("1" + i.to_s).to_i
  digits = digits num

  success = true
  2.upto 6 do |m|
    if digits(num*m) != digits
      success = false
      break
    end
  end

  if !success
    i += 1
    next
  end

  puts num
  2.upto 6 do |m|
    p num*m
  end
  exit
end

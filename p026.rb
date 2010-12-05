def find_repeat(num,denom)
  rdigits = num.to_s
  answer = ""
  i = remainder = 0
  rems = {}

  while (rdigits.length >= i || remainder > 0)
    next_digit = (i < rdigits.length ? rdigits[i,1] : "0")
    remainder = "#{remainder}#{next_digit}".to_i

    answer += (remainder/denom).to_s
    remainder = (remainder%denom)

    i += 1

    if rems.include? remainder
      return [answer, answer[(rems[remainder])..(i-1)]]
    else
      rems[remainder] = i
    end
  end

  [answer, ""]
end

results = []
max = 0
2.upto 1000 do |i|
  answer, rep = find_repeat(1,i)

  if rep.length > max
    puts "#{i} (#{rep.length}): #{rep[0,20]}"
    max = rep.length
  end
end

puts (1..100).inject(1){|sum,i| sum *= i}.to_s.split(//).inject(0){|sum,i| sum += i.to_i}

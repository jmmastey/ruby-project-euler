puts ((1..1000).inject(0) { |sum,k| sum += k**k }).to_s[-11,10]

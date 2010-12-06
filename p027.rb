class Fixnum
  def prime?
    ('1' * self.to_i) !~ /^1?$|^(11+?)\1+$/
  end
end

max = [0,0,0]
alim = 1000
blim = 1000

# for n = 0, f(n) = b, so b needs to be prime
bvals = ((blim*-1)..(blim)).select { |k| k.abs.prime? }

#precompute
sqs = []
0.upto 1000 do |n|
  sqs << n**2
end

(alim*-1).upto alim do |a|
  bvals.each do |b|
    # try iterate
    0.upto 1000 do |n|

      #did we win?
      ans = (sqs[n]+(a*n)+b)
      if ans < 0 || !ans.prime?
        if n > max[0]
          max = [n, a, b]
          puts "n^2 + #{a}n + #{b} got #{n}"
        end
        break
      end

    end
  end
end

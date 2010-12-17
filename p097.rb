num = 1;
pow = 7830457;

1.upto pow do |i|
  num *= 2

  if 0 == i % 100
    num %= 1e10
  end
end

num %= 1e10
num *= 28433;
num += 1;

p num.to_i.to_s[-10..-1];

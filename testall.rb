1.upto 400 do |i|
  test = "p%03d.rb" % i
  next unless File.exists? test

  start = Time.now
  res = `ruby #{test}`
  endt = Time.now

  puts "Executed %d in %3.5fs and got %s" % [i, (endt.to_f-start.to_f), res]
end

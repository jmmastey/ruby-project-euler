#!/usr/bin/ruby

# ran this overnight (6B rolls) and still no answer.
# I should consider finding faster random numbers (maybe read a few MB from
# /dev/urandom), since that is likely the bottleneck.

def roll(n,d)
  (1..n).inject(0) { |s,i| s + (rand*d).ceil }
end

@inc = 100_000
@threads = 7
if 0 == ARGV.length
  sum = 0
  @inc.times { sum += 1 if roll(9,4) > roll(6,6) }
  puts sum
  exit
end

runs = 0
wins = 0
while true
  a = []
  @threads.times do
    a << Thread.new { Thread.current['wins'] = `./p205.rb` }
  end

  a.each do |t|
    t.join
    runs += @inc
    wins += t['wins'].to_i
  end

  puts "#{wins} of #{runs}"
  p wins*1.0/runs
end

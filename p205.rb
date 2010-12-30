def roll(n,d)
  (1..n).inject(0) { |s,i| s + (rand*d).ceil }
end

runs = 1_000_000_000
wins = 0
runs.times { wins += 1 if roll(9,4) > roll(6,6) }

p wins
p wins*1.0/runs

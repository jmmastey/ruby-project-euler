#!/usr/bin/ruby

@lim = 1_000_000_000
@threads = 7

def very_odd? i
  !!(/^[13579]+$/.match i.to_s)
end

def run st, fin
  sum = 0
  st.upto(fin) { |i| sum += process(i) }

  print sum
end

def process i
  return 0 if i % 10 == 0

  r = i.to_s.reverse
  ri = r.to_i
  return 0 unless i > ri

  return 0 if !(i.even? ^ ri.even?)

  s = i + ri
  return 0 if s.even?

  return 2 if very_odd? s
  return 0
end

exit unless ARGV.length > 0

unless "go" == ARGV[0]
  run ARGV[0].to_i, ARGV[1].to_i
else
  i = 0
  a = []
  inc = @lim/@threads
  @threads.times do
    a << Thread.new {
      s = i
      i += inc
      f = i-1
      f = @lim if @lim-inc < i
      puts "starting #{s} - #{f}\n"
      Thread.current['sum'] = `./p145.rb #{s} #{f}`
    }
  end

  sum = 0
  a.each { |t| t.join; sum += t['sum'].to_i }

  p sum
end

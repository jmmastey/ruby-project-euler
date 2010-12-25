require 'mathn'

max = (1e6).to_i
adjacent = 3/7
max.downto 0 do |i|
  if 0 == (i*adjacent) % 1
    p "#{(i*adjacent)-1}/#{i}"
    exit
  end
end

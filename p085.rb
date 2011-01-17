
gridw = 3
gridh = 2
lim = 100
tgt = 2_000_000
dist = tgt
winner = nil

1.upto lim do |gridw|
  1.upto lim do |gridh|

    rects = 0
    1.upto gridw do |w|
      1.upto gridh do |h|
        hmoves = gridw - (w-1)
        vmoves = gridh - (h-1)
        rects += hmoves*vmoves
      end
    end


    if (tgt - rects).abs < dist
      winner = [gridw, gridh, gridw*gridh, rects]
      dist = (tgt - rects).abs
    end
  end
end

p winner

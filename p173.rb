
tiles = 1_000_000

# calc perimeters
min_p = 3
max_p = (tiles/4).ceil + 2

@squares = {}
def square_of n
  @squares[n] = n**2 unless @squares.include?(n)
  @squares[n]
end

valid_squares = 0
min_p.upto max_p do |perimeter|
  #p perimeter if perimeter % 100 == 0
  area = square_of(perimeter)

  tile_diff = area-tiles
  min_hole = perimeter.odd? ? 1 : 2
  min_hole = (tile_diff**0.5).ceil if tile_diff > 0

  max_hole = perimeter-2

  # we properly calculated the hole sizes, so just add the steps
  valid_squares += (1+(max_hole-min_hole)/2)
end

p valid_squares

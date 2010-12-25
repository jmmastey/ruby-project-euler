
@spaces = [
  'GO',   'A1', 'CC1', 'A2',  'T1', 'R1', 'B1',  'CH1', 'B2', 'B3',
  'JAIL', 'C1', 'U1',  'C2',  'C3', 'R2', 'D1',  'CC2', 'D2', 'D3',
  'FP',   'E1', 'CH2', 'E2',  'E3', 'R3', 'F1',  'F2',  'U2', 'F3',
  'G2J',  'G1', 'G2',  'CC3', 'G3', 'R4', 'CH3', 'H1',  'T2', 'H2'
]

def space name
  @spaces.index name
end

# tired of computing this
JAIL = space('JAIL')

@chests = [space('GO'), JAIL, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil].shuffle

@chances = [space('GO'), JAIL, space('C1'), space('E3'), space('H2'),
           space('R1'), 'NR', 'NR', 'NU', 'M3', nil, nil, nil, nil, nil, nil].shuffle

def move n
  @position = (@position + n) % @spaces.length
end

@chest = 0
def chest
  card = @chests[@chest]
  @chest += 1
  if @chest == @chests.length
    @chests.shuffle!
    @chest = 0
  end
  card
end

@chance = 0
def chance
  card = @chances[@chance]
  @chance += 1
  if @chance == @chances.length
    @chances.shuffle!
    @chance = 0
  end
  card
end

def roll sides
  [(rand*sides).ceil,(rand*sides).ceil]
  #(rand*11).ceil+1
end

def put_table
  idx = 0
  4.times do
    0.upto 9 do |o|
      pct = @hits[(idx+o)].to_f/@total.to_f*100
      print "%4s:%1.2f" % [@spaces[idx+o], pct]
    end
    idx += 10
    puts ""
  end
  puts "#{@total} rolls\n\n"
end

def go_to_jail
  @position = JAIL
  @went_to_jail = true
end

def next_railroad
  while true
    move 1
    return @position if @spaces[@position][0,1] == "R"
  end
end

def next_utility
  while true
    move 1
    return @position if @spaces[@position][0,1] == "U"
  end
end

def evaluate_position
  placename = @spaces[@position]
  card = -1

  # go directly to jail
  return go_to_jail if 'G2J' == placename

  # take cards
  card = chest if "CC" == placename[0,2]
  card = chance if "CH" == placename[0,2]

  return if -1 == card
  return go_to_jail if card == JAIL
  return next_railroad if card == 'NR'
  return next_utility if card == 'NU'

  if card.kind_of? Integer
    position = card
  elsif card == 'M3'
    move -3
    evaluate_position
  end
end

def take_roll
  dice = roll(@sidedness)
  move dice[0]+dice[1]
  evaluate_position

  dice
end

def take_turn
  @went_to_jail = false
  doubles = 0
  dice = take_roll
  while dice[0] == dice[1]
    doubles += 1
    if 3 == doubles
      @went_to_jail = true
      @position = JAIL
      return
    end

    dice = take_roll
  end
end

def print_results
  p (@hits.to_a.sort_by { |l| l[1] }).last(3).reverse
end
at_exit { print_results }

@sidedness = 6
@hits = ((0..39).inject({}) { |h,i| h[i] = 0; h })
@total = 0
@position = 0
@went_to_jail = false

i = 1
while true
  take_turn

  @total += 1
  @hits[@position] += 1

  put_table if @total%100_000 == 0
end

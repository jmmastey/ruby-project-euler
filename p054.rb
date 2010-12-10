require 'tools'

def score_hand cards
  grouped = cards(cards)
  scores = (cards.inject([]) { |a,c| a << score_card(c[0,1]) }).sort


  # royal flush
  return 10e100 if (flush?(cards) && [10,11,12,13,14] == scores)

  # straight flush
  return 10e90 * scores.max if (flush?(cards) && straight?(scores))

  # 4oak
  return 10e80 * scores.max if (grouped.value? 4)

  # full house
  if grouped.value?(3) && grouped.value?(2)
    return 10e70 * ((10*value_for_ct(grouped,3))+value_for_ct(grouped,2))
  end

  # flush
  return 10e60 * scores.max if flush?(cards)

  # straight
  return 10e50 * scores.max if straight?(scores)

  # 3oak
  return 10e40 * scores.max if grouped.value?(3)

  # 2 pair
  return 10e30 if grouped.value_ct(2) == 2

  # pair
  return (10e20 * value_for_ct(grouped,2) + score_all_cards(grouped)) if grouped.value?(2)

  # nothing
  return 10e10 + score_all_cards(grouped)
end

def flush? cards
  cards.inject([]) { |a,c| a << c[1,1] }.uniq.length == 1
end

def straight? scores
  m = nil
  scores.each do |k|
    if !m
      m = k
      next
    end
    return false unless k == m+1
    m = k
  end
  return true
end

def cards cards
  cards.inject({}) do |h,c|
    card = score_card(c[0,1])
    h[card] ||= 0
    h[card] += 1
    h
  end
end

def score_card face
  return case face
    when 'A' then 14
    when 'K' then 13
    when 'Q' then 12
    when 'J' then 11
    when 'T' then 10
    else face.to_i
  end
end

def score_all_cards hand
  scale = 8
  points = 0
  hand.to_a.sort.reverse.each do |v,i|
    points += i * v * 10**scale
    scale -= 2
  end

  points
end

def value_for_ct h, ct
  (h.inject([]) { |a,s| a << score_card(s[0]) if s[1] == ct; a }).max
end







hands = File.read("p054_poker.txt").split(/\r\n/)
p1wins = 0

hands = [
  #["TH", "JH", "QH", "KH", "AH"],
  #["TH", "JH", "QH", "KH", "9H"],
  #["9D", "9S", "9C", "KH", "9H"],
  ["2D", "3S", "8C", "6H", "8H"],
  ["2D", "3S", "4C", "8H", "8H"],
]
hands.each { |h| p score_hand h }
exit

hands.each do |hand|
  cards = hand.split
  p1, p2 = cards[0..4], cards[5..9]

  p1wins += 1 if score_hand(p1) > score_hand(p2)
end

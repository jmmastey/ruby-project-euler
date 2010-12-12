require 'tools'

def score_hand cards
  grouped = cards(cards)
  scores = (cards.inject([]) { |a,c| a << score_card(c[0,1]) }).sort


  # royal flush
  return 6e11 if (flush?(cards) && [10,11,12,13,14] == scores)

  # straight flush
  return 4e11 + (1e10 * scores.max) if (flush?(cards) && straight?(scores))

  # 4oak
  return 3e11 + (1e9 * value_for_ct(grouped,4)) + score_all_cards(grouped,1) if grouped.value? 4

  # full house
  if grouped.value?(3) && grouped.value?(2)
    return 1e11 + (1e10*value_for_ct(grouped,3)) + (1e8*value_for_ct(grouped,2)) + score_all_cards(grouped)
  end

  # flush
  return 9e10 + score_all_cards(grouped) if flush?(cards)

  # straight
  return 7e10 + (1e9 * scores.max) if straight?(scores)

  # 3oak
  return 4e10 + (1e9 * scores.max) + (1e2 * score_all_cards(grouped,2)) + score_all_cards(grouped,1) if grouped.value?(3)

  # 2 pair
  if grouped.value_ct(2) == 2
    twos = (grouped.select { |k,v| v == 2 }).sort.reverse
    tscore = twos.inject(0) { |sum,s| sum += s[0]; sum *= 100; sum }
    return 1e10 + (tscore * 1e5) + score_all_cards(grouped,1)
  end

  # pair
  return 6e9 + (1e7 * value_for_ct(grouped,2)) + score_all_cards(grouped,1) if grouped.value?(2)

  # nothing
  return 1e9 + score_all_cards(grouped)
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

def score_all_cards(hand, maxct = 5)
  scale = 8
  points = 0
  hand.to_a.sort.reverse.each do |v,i|
    if i > maxct
      scale -= 2
      next
    end

    points += i * v * 5**scale
    scale -= 2
  end

  points
end

def value_for_ct h, ct
  (h.inject([]) { |a,s| a << score_card(s[0]) if s[1] == ct; a }).max
end

=begin
hands = [
  ["2D", "3S", "4C", "7H", "5H"],
  ["2D", "3S", "4C", "8H", "5H"],
  ["AD", "KS", "QC", "JH", "8H"],
  ["AD", "KS", "QC", "JH", "9H"],
  ["2D", "2S", "3C", "4H", "5H"],
  ["2D", "2S", "3C", "4H", "6H"],
  ["AD", "AS", "KC", "QH", "TH"],
  ["AD", "AS", "KC", "QH", "JH"],
  ["2D", "2S", "3C", "3H", "4H"],
  ["2D", "2S", "3C", "3H", "5H"],
  ["AD", "AS", "KC", "KH", "JH"],
  ["AD", "AS", "KC", "KH", "QH"],
  ["2D", "2S", "2C", "3H", "4H"],
  ["2D", "2S", "2C", "3H", "5H"],
  ["3D", "3S", "3C", "4H", "5H"],
  ["AD", "AS", "AC", "KH", "JH"],
  ["AD", "AS", "AC", "KH", "QH"],
  ["2D", "3S", "4C", "5H", "6H"],
  ["7D", "3S", "4C", "5H", "6H"],
  ["KS", "QC", "JH", "TH", "9S"],
  ["AD", "KS", "QC", "JH", "TH"],
  ["2H", "2H", "2H", "3H", "4H"],
  ["2H", "2H", "2H", "3H", "5H"],
  ["AH", "AH", "AH", "KH", "JH"],
  ["AH", "AH", "AH", "KH", "QH"],
  ["2H", "2H", "2H", "3H", "3H"],
  ["2H", "2H", "2H", "4H", "4H"],
  ["AH", "AH", "AH", "QH", "QH"],
  ["AH", "AH", "AH", "KH", "KH"],
  ["2H", "2H", "2H", "2H", "3H"],
  ["2H", "2H", "2H", "2H", "4H"],
  ["3H", "3H", "3H", "3H", "2H"],
  ["AH", "AH", "AH", "AH", "QH"],
  ["AH", "AH", "AH", "AH", "KH"],
  ["2H", "3H", "4H", "5H", "6H"],
  ["3H", "4H", "5H", "6H", "7H"],
  ["QH", "JH", "TH", "9H", "8H"],
  ["KH", "QH", "JH", "TH", "9H"],
  ["TH", "JH", "QH", "KH", "AH"],
]
hands.each { |h| p score_hand h }
exit
=end


hands = File.read("p054_poker.txt").split(/\r\n/)
p1wins = []

hands.each do |hand|
  cards = hand.split
  p1, p2 = cards[0..4], cards[5..9]

  p1wins << [p1,p2] if score_hand(p1) > score_hand(p2)
end

#p1wins[0..10].each { |v| p v }
p p1wins.length

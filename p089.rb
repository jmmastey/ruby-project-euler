
# this works in .1s, but man is it ugly. scoring on the fly would probably
# make it a little cleaner, as well as generating @longdigits automatically.
# oh well, it works.

@digits = {
  'I' => 1,
  'V' => 5,
  'X' => 10,
  'L' => 50,
  'C' => 100,
  'D' => 500,
  'M' => 1000
}

@leaders = {"I" => ["V","X"], "X" => ["L","C"], "C" => ["D","M"]}
@longdigits = [
  [1000,'M'],
  [900,'CM'],
  [500,'D'],
  [400,'CD'],
  [100,'C'],
  [90,'XC'],
  [50,'L'],
  [40,'XL'],
  [10,'X'],
  [9,'IX'],
  [5,'V'],
  [4,'IV'],
  [1,'I']
]

def score s
  score = 0
  char = s[0,1]
  char_i = 0
  i = 1
  while i <= s.length
    if char != s[i,1]
      # reversed pair
      if @leaders.include?(char) && @leaders[char].include?(s[i,1])
        i += 1
        score += @digits[s[i-1,1]] - @digits[s[char_i,1]]

      # std repetition
      else
        score += (i-char_i) * @digits[s[char_i,1]]
      end

      char = s[i,1]
      char_i = i
    end
    i += 1
  end

  score
end

def min_roman n
  str = ""
  @longdigits.each do |i|
    digitn = n/i[0]
    str += i[1] * digitn
    n -= digitn * i[0]
  end

  str
end

savings = 0
File.open("p089_roman.txt") do |file|
  while line = file.gets
    roman = line.chomp
    n = score(roman)
    opt = min_roman n
    s = roman.length-opt.length

    savings += s
    #p "#{roman} scores #{n} and wastes #{s}"
  end
end

p savings


class Fixnum

  @@eng_words = {
    :lownums => { 0 => "zero", 1 => "one", 2 => "two", 3 => "three", 4 => "four", 5 => "five", 6 => "six", 7 => "seven", 8 => "eight", 9 => "nine",
      10 => "ten", 11 => "eleven", 12 => "twelve", 13 => "thirteen", 14 => "fourteen", 15 => "fifteen", 16 => "sixteen", 17 => "seventeen", 18 => "eighteen", 19 => "nineteen" },
    :tens => { 2 => "twenty", 3 => "thirty", 4 => "forty", 5 => "fifty", 6 => "sixty", 7 => "seventy", 8 => "eighty", 9 => "ninety" },
    :dash => "-",
    :and => "and",
    :places => { :hundred => "hundred", :thousand => "thousand" }
  }

  def to_eng
    n = self.to_i
    return @@eng_words[:lownums][n] if n < 20

    if n < 100
      tens = n/10
      ones = n%10

      return @@eng_words[:tens][tens]+(ones == 0 ? "" : (@@eng_words[:dash]+ones.to_eng))
    end

    if n < 1000
      hundreds = n/100
      rest = n%100

      r = hundreds.to_eng+" "+@@eng_words[:places][:hundred]
      r = r+" "+@@eng_words[:and]+" "+rest.to_eng if 0 != rest
      return r
    end

    if n < 100000
      thousands = n/1000
      hundreds = (n%1000)/100
      rest = n%100

      r = thousands.to_eng+" "+@@eng_words[:places][:thousand]
      r = r+" "+hundreds.to_eng+" "+@@eng_words[:places][:hundred] if hundreds > 0
      r = r+" "+@@eng_words[:and]+" "+rest.to_eng if 0 != rest
      return r
    end

    return "a lot"
  end

end

lstring = ""
1.upto 1000 do |i|
  lstring += i.to_eng
end


puts lstring.gsub(/[^a-z]/, '').length

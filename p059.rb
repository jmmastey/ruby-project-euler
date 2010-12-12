require 'tools'

cipher = File.read('p059_cipher1.txt').chomp.split(/,/).to_is
chars = (97..122) # lowercase a-z

chars.each do |a|
  chars.each do |b|
    chars.each do |c|
      key = [a,b,c]

      output = ""
      sum = 0
      valid = true
      0.upto cipher.length-1 do |ci|
        trn_i = cipher[ci]^key[ci%3]
        trn = trn_i.chr

        # we fell out of ascii, this cannot be right
        if 32 > trn_i || 127 <= trn_i
          valid = false
          break
        end

        output += trn
        sum += trn_i
      end

      skey = key.inject("") { |str,c| str + c.chr }
      if valid
        # the word "the" will almost definitely occur in the output
        # so scan the results from here for something credible
        puts "#{skey} #{sum} #{output[0..60]}" if [] != (output.grep /the/)
      end
    end
  end
end

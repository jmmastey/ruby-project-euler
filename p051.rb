require 'tools'

max = 1000000
target_length = 8

# 12334 => [*2334,1*334,123*4,12*34,12**4,1233*]
def asterisk_permutations str
  chars = str.split(//).uniq
  ret = []
  chars.each do |c|
    ret += vary_for_digit(str, c)
  end

  ret.uniq
end

# 12334, 3 => [12334,123*4,12*34,12**4]
def vary_for_digit(str, d)
  return [] unless str.index d

  idx = str.index d

  replaced = str+""
  replaced[idx] = "*"

  ret = vary_for_digit(replaced, d)

  replaced_too = str+""
  replaced_too[idx] = "%"
  ret_too = vary_for_digit(replaced_too, d)
  ret_too.each do |r|
    ret << r.gsub("%",d)
  end

  ret << replaced

  unreplaced = replaced+""
  unreplaced[idx] = d
  ret << unreplaced

  ret
end

ans = {}
primes = Sieve.primes_to max
primes.each do |pr|
  permutations = asterisk_permutations pr.to_s

  permutations.delete pr.to_s.gsub(/\d/, "*")
  permutations.delete pr.to_s

  # sorted into asterisks and put when finished
  permutations.each do |prm|
    ans[prm] ||= []
    ans[prm] << pr

    if ans[prm].length == target_length
      print prm + " "
      p ans[prm].sort
    end
  end
end

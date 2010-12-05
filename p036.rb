
def is_palindrome? s
  s.reverse == s
end

max = 1000000
palindromes = []

(1..(max-1)).step(2) do |i|
  if is_palindrome?(i.to_s) && is_palindrome?(i.to_s(base=2))
    palindromes << i
  end
end

puts palindromes.inject(0) { |sum,i| puts i; sum += i }

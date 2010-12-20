digits = {}

i = 0
lim = 30
while true
  i += 1

  cube = i**3
  cdig = cube.to_s.split(//).sort.join('')
  digits[cdig] ||= []
  digits[cdig] << cube

  if digits[cdig].length == lim
    p digits[cdig].sort
    exit
  end
end

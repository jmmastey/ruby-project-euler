@st = 1_000_000_000_000

# m**2 - 2y**2 = -1
# n = 2

d = 2
sqrt_d = d**0.5
sqrt_di = sqrt_d.to_i
return [1,0] if sqrt_d == sqrt_di

# setup!
n = 1
bigp = [0, sqrt_di]                               # (15,16)
bigq = [0, (d-sqrt_di**2)]                        # (18,19)
a = [sqrt_di, ((sqrt_di + bigp[1])/bigq[1]).to_i] # (8,21)
p = [sqrt_di, a[0]*a[1]+1]                        # (9,10)
q = [1, a[1]]                                     # (12,13)

iterate = lambda do
  bigp[n] = a[n-1] * bigq[n-1] - bigp[n-1]        # (17)
  bigq[n] = (d - bigp[n]**2) / bigq[n-1]          # (20)
  a[n] = ((a[0] + bigp[n])/ bigq[n]).to_i         # (21)
  p[n] = a[n] * p[n-1] + p[n-2]                   # (11)
  q[n] = a[n] * q[n-1] + q[n-2]                   # (14)
end

ans = 0
while true
  n += 1
  iterate.call

  next unless p[n-1] > @st
  ans = p[n-1]**2 - 2*q[n-1]**2
  p([p[n-1],q[n-1]], ans)
  exit if ans == -1
end

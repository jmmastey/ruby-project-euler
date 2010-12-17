# since we want the last 10 digits, we can see that they have a period of 7812500 (4 * 5**9)
print (2**(7830457 % (4 * 5**9)) * 28433 + 1) % 10000000000

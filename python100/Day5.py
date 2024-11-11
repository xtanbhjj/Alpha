'''
for num in range(100, 1000):
    low = num % 10
    mid = num // 10 % 10
    high = num // 100
    if num == low ** 3 + mid ** 3 + high ** 3:
        print(num)
'''

'''
for i in range(0, 21):
    for j in range(0, 34):
        k = 100 - i - j
        if i * 5 + j * 3 + k / 3 == 100:
            print("%d %d %d" % (i, j, k))
'''

'''
a = 1
b = 1
n = int(input())
n -= 2
print("1\n1")
while n:
    n -= 1
    tmp = b
    b = a + b
    a = tmp
    print(b)
'''

'''
for i in range(1, 10000):
    num = 0
    for j in range(1, i):
        if not (i % j):
            num += j
    if num == i:
        print(i)
'''

st = [0 for _ in range(0, 200)]
prime = []

for i in range(2, 200):
    if not st[i]:
        prime.append(i)
    for j in prime:
        if i * j >= 200:
            break
        st[i * j] = 1
        if i % j == 0:
            break

for i in prime:
    print(i)
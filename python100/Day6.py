def gcd(a, b):
    if not b:
        return a
    else:
        return gcd(b, a % b)


def is_palindrome(num):
    tmp = num
    total = 0
    while tmp:
        total = total * 10 + tmp % 10
        tmp //= 10
    return total == num


def is_prime(num):
    if num < 2:
        return False
    for i in range(2, int(num ** 0.5) + 1):
        if num % i == 0:
            return False
    return True

def main():
    n = int(input())
    for i in range(n):
        num = int(input())
        if is_palindrome(num) and is_prime(num):
            print("Yes")
        else:
            print("No")


if __name__ == '__main__':
    main()
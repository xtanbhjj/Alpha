class Solution:
    def imageSmoother(self, img: List[List[int]]) -> List[List[int]]:
        n, m = len(img), len(img[0])
        res = [[0] * m for _ in range(n)]
        dx = (-1, -1, -1, 1, 1, 1, 0, 0, 0)
        dy = (0, -1, 1, 0, -1, 1, 0, -1, 1)
        for i in range(n):
            for j in range(m):
                ans = 0
                cnt = 0
                for k in range(9):
                    x = i + dx[k]
                    y = j + dy[k]
                    if x < 0 or x >= n or y < 0 or y >= m:
                        continue
                    ans += img[x][y]
                    cnt += 1
                res[i][j] = ans // cnt
        return res
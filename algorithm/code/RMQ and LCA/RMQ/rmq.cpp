#include <cstdio>
#include <cmath>
#include <algorithm>
using namespace std;

int f[1001][11];

int main()
{
	freopen("rmq.in", "r", stdin);
	freopen("rmq.out", "w", stdout);
	int n;
	scanf("%d", &n);
	for (int i=1; i<=n; ++i) scanf("%d", f[i]);
	for (int j=1; (1<<j)<=n; ++j)
		for (int i=1; i+(1<<j)-1<=n; ++i)
			f[i][j]=min(f[i][j-1], f[i+(1<<(j-1))][j-1]);
	int m, x, y, k;
	scanf("%d", &m);
	while (m--)
	{
		scanf("%d%d", &x, &y);
		k=(int)floor(log2(y-x+1));
		printf("%d\n", min(f[x][k], f[y-(1<<k)+1][k]));
	}
	return 0;
}


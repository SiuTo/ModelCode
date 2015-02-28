#include <cstdio>
#include <cmath>
#include <algorithm>
using namespace std;

const int Maxn=1001, Maxk=11;

int g[Maxn], x[Maxn*2], next[Maxn*2], d[Maxn], stack[Maxn], f[Maxn][Maxk];

int Log2(int x)
{
	if (x) return floor(log2(x));
	else return -1;
}

void dfs(int dep, int v, int fa)
{
	d[v]=dep;
	stack[dep]=v;
	for (int i=0; (1<<i)<=dep; ++i) f[v][i]=stack[dep-(1<<i)];
	for (int p=g[v]; p; p=next[p])
		if (x[p]!=fa) dfs(dep+1, x[p], v);
}

int lca(int x, int y)
{
	if (d[x]<d[y]) swap(x, y);
	while (d[x]>d[y]) x=f[x][Log2(d[x]-d[y])];
	if (x!=y)
	{
		int k=Log2(d[x]);
		while (f[x][0]!=f[y][0])
			if (f[x][k]==f[y][k]) --k; else
			{
				x=f[x][k]; y=f[y][k];
				k=min(Log2(d[x]), k-1);
			}
		x=f[x][0];
	}
	return x;
}

int main()
{
	int n;
	scanf("%d", &n);
	int tot=0, v, u;
	for (int i=1; i<n; ++i)
	{
		scanf("%d%d", &v, &u);
		x[++tot]=u; next[tot]=g[v]; g[v]=tot;
		x[++tot]=v; next[tot]=g[u]; g[u]=tot;
	}
	dfs(0, 1, 0);
	int Q;
	scanf("%d", &Q);
	while (Q--)
	{
		scanf("%d%d", &v, &u);
		printf("%d\n", lca(v, u));
	}
	return 0;
}


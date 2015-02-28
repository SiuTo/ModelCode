#include <cstdio>
#include <cstring>
#include <algorithm>
using namespace std;

const int Maxn=1001;

int dfn, root, a[Maxn], b[Maxn], g[Maxn], next[Maxn*Maxn], x[Maxn*Maxn], cnt[Maxn];

void dfs(int v, int fa)
{
	int h=0;
	a[v]=b[v]=++dfn;
	for (int p=g[v]; p; p=next[p])
		if (x[p]!=fa)
		{
			if (a[x[p]]) b[v]=min(b[v], a[x[p]]); else
			{
				dfs(x[p], v);
				if (v==root) ++h; else 
				{
					b[v]=min(b[v], b[x[p]]);
					if (b[x[p]]>=a[v]) ++h;
				}
			}
		}
	if (v!=root) ++h;
	cnt[v]=h;
}

int main()
{
	int n, m, v, u;
	scanf("%d%d", &n, &m);
	memset(g, 0, sizeof g);
	int tot=0;
	for (int i=0; i<m; ++i)
	{
		scanf("%d%d", &v, &u);
		x[++tot]=u; next[tot]=g[v]; g[v]=tot;
		x[++tot]=v; next[tot]=g[u]; g[u]=tot;
	}
	dfn=0;
	memset(a, 0, sizeof a);
	root=1;
	dfs(root, 0);
	for (int i=1; i<=n; ++i)
		if (cnt[i]>1) printf("%d %d\n", i, cnt[i]);
	return 0;
}


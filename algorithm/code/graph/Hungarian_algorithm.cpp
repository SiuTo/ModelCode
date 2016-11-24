#include <cstdio>
#include <cstring>
const int Maxn=201;
bool u[Maxn];
int g[Maxn],link[Maxn],x[Maxn*Maxn],next[Maxn*Maxn];

bool dfs(int v)
{
	for (int p=g[v]; p; p=next[p])
		if (!u[x[p]])
		{
			u[x[p]]=true;
			if (!link[x[p]] || dfs(link[x[p]]))
			{
				link[x[p]]=v; return true;
			}
		}
	return false;
}

int main()
{
	int n,i,j,col,tot=0;
	scanf("%d",&n);
	for (i=1; i<=n; ++i)
		for (j=1; j<=n; ++j)
		{
			scanf("%d",&col);
			if (col)
				x[++tot]=j, next[tot]=g[i], g[i]=tot;
		}
	int m=0;
	for (i=1; i<=n; ++i)
	{
		memset(u,0,sizeof u);
		if (dfs(i)) ++m;
	}
	printf("%d\n",m);
	return 0;
}

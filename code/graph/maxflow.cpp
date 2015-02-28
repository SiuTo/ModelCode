#include <cstdio>
#include <cstring>
#include <algorithm>
using namespace std;

const int Maxn=16, Maxm=2010, INF=1000001;

int n, S, T, g[Maxn], h[Maxn], vh[Maxn], g0[Maxn], x[Maxm], next[Maxm], r[Maxm];

int dfs(int v, int f)
{
    if (v==T) return f;
    int minh=n-1, first=g[v];
    do{
        int p=g[v];
        if (r[p])
        {
            if (h[v]==h[x[p]]+1)
            {
                int flow=dfs(x[p], min(f, r[p]));
                if (flow)
                {
                    r[p]-=flow; r[p^1]+=flow;
                    return flow;
                }
                if (h[S]==n) return 0;
            }
            minh=min(minh, h[x[p]]);
        }
        g[v]=next[p];
        if (!g[v]) g[v]=g0[v];
    }while (g[v]!=first);
    --vh[h[v]];
    if (!vh[h[v]]) h[S]=n;
    h[v]=minh+1;
    ++vh[h[v]];
    return 0;
}

int main()
{
	int tot=1, m, a, b, c;
	scanf("%d%d", &n, &m);
	memset(g, 0, sizeof g);
	while (m--)
	{
		scanf("%d%d%d", &a, &b, &c);
		x[++tot]=b; r[tot]=c; next[tot]=g[a]; g[a]=tot;
		x[++tot]=a; r[tot]=0; next[tot]=g[b]; g[b]=tot;
	}
	S=1, T=n;
	memset(h, 0, sizeof h);
	memset(vh, 0, sizeof vh);
	memcpy(g0, g, sizeof g);
	vh[0]=n;
	int maxflow=0;
	while (h[S]<n)
		maxflow+=dfs(S, INF);
	printf("%d\n", maxflow);
    return 0;
}


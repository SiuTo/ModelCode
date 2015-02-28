#include <cstdio>
#define rev(_x) (((_x-1)^1)+1)
const int Maxn=16001, Maxm=120001;
int n,m,tot,x[Maxm],next[Maxm],g0[Maxn],g1[Maxn],g2[Maxn],o[Maxn],u[Maxn],choose[Maxn],into[Maxn],oppo[Maxn];

void addedge(int *g,int a,int b)
{
	x[++tot]=b; next[tot]=g[a]; g[a]=tot;
}

void dfs0(int v)
{
	u[v]=-1;
	for (int p=g0[v]; p; p=next[p])
		if (!u[x[p]]) dfs0(x[p]);
	o[m++]=v;
}

void dfs1(int v)
{
	u[v]=m;
	for (int p=g1[v]; p; p=next[p])
		if (u[x[p]]<0) dfs1(x[p]);
		else if (u[x[p]]!=m)
		{
			addedge(g2,u[x[p]],m);
			++into[m];
		}
}

void toposort()
{
	int q1=0, q2=0;
	for (int i=1; i<=m; ++i)
		if (!into[i]) o[q2++]=i;
	while (q1<q2)
		for (int p=g2[o[q1++]]; p; p=next[p])
		{
			--into[x[p]];
			if (!into[x[p]]) o[q2++]=x[p];
		}
}

int main()
{
	scanf("%d%d",&n,&m);
	int a,b,i;
	tot=0;
	while (m--)
	{
		scanf("%d%d",&a,&b);
		addedge(g0,a,rev(b));
		addedge(g1,rev(b),a);
		addedge(g0,b,rev(a));
		addedge(g1,rev(a),b);
	}
	m=0;
	for (i=1; i<=n*2; ++i)
		if (!u[i]) dfs0(i);
	m=0;
	for (i=0; i<n*2; ++i)
		if (u[o[i]]<0)
		{
			++m;
			dfs1(o[i]);
		}
	for (i=1; i<=n; ++i)
		if (u[i*2-1]==u[i*2])
		{
			puts("NIE");
			return 0;
		}
	for (i=1; i<=n; ++i) oppo[u[i*2-1]]=u[i*2], oppo[u[i*2]]=u[i*2-1];
	toposort();
	for (i=m; i>=1; --i)
		if (!choose[i]) choose[i]=1, choose[oppo[i]]=-1;
	for (i=1; i<=n; ++i) printf("%d\n",choose[u[o[i*2]]]>0? i*2:i*2-1);
	return 0;
}

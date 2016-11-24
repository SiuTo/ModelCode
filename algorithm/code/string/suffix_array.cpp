#include <cstdio>
#include <cstring>
const int Maxn=50005;
typedef int Arr[Maxn];
char str[Maxn];
int n,tot;
Arr x,next,g,sa,sa1,rank,rank1;

void add(int a,int b)
{
	x[++tot]=b; next[tot]=g[a]; g[a]=tot;
}

void getsa()
{
	int i,j,k,m,p,mm,last,now;
	memset(g,0,sizeof g); tot=0;
	for (i=0; i<n; ++i) add(str[i],i+1);
	for (i=1,m=j=0; i<255; ++i)
		if (g[i])
		{
			++m;
			for (p=g[i]; p; p=next[p]) sa[++j]=x[p],rank[x[p]]=m;
		}
	for (k=1; m<n; k<<=1)
	{
		for (i=n-k+1,j=0; i<=n; ++i) sa1[++j]=i;
		for (i=1; i<=n; ++i)
			if (sa[i]>k) sa1[++j]=sa[i]-k;
		memset(g,0,sizeof g); tot=0;
		for (i=n; i; --i) add(rank[sa1[i]],sa1[i]);
		for (i=1,mm=m,j=m=0; i<=mm; ++i)
		{
			last=-1;
			for (p=g[i]; p; p=next[p])
			{
				sa[++j]=x[p];
				now=x[p]+k>n? 0:rank[x[p]+k];
				if (now>last) ++m, last=now;
				rank1[x[p]]=m;
			}
		}
		memcpy(rank,rank1,sizeof rank);
	}
}

int main()
{
	scanf("%s",str);
	n=strlen(str);
	getsa();
	int ans=(long long)n*(n+1)/2;
	for (int i=1,k=0; i<=n; ++i)
	{
		if (rank[i]==1) k=0; else
			for (k=(k? k-1:0); str[i+k-1]==str[sa[rank[i]-1]+k-1]; ++k);
		ans-=k;
	}
	printf("%d\n",ans);
	return 0;
}


#include <cstdio>
#include <cstring>
#include <algorithm>
using namespace std;

const int Maxc=128, Maxl=1000002;

char a[Maxl], b[Maxl];
int bmBc[Maxc], suff[Maxl], bmGs[Maxl];

void preBmBc(char *a, int m, int *bmBc)
{
	for (int i=0; i<Maxc; ++i) bmBc[i]=-1;
	for (int i=0; i<m; ++i) bmBc[a[i]]=i;
}

void suffixes(char *a, int m, int *suff)
{
	int l=m-1, r=m-2, k;
	suff[m-1]=m;
	for (int i=m-2; i>=0; --i)
		if (suff[m-1-r+i]<i-l+1) suff[i]=suff[m-1-r+i]; else
		{
			for (k=max(i-l+1, 0); i-k>=0 && a[m-1-k]==a[i-k]; ++k);
			l=i-k+1; r=i;
			suff[i]=k;
		}
}

void preBmGs(char *a, int m, int *bmGs)
{
	suffixes(a, m, suff);
	int last=-1, j=0;
	for (int i=m-1; i>=0; --i)
	{
		for (; j<m-1-i; ++j)
			if (suff[j]==j+1) last=j;
		bmGs[i]=last;
	}
	for (int i=0; i<m-1; ++i) bmGs[m-1-suff[i]]=i;
}

int main()
{
	int m, n;
	scanf("%d%s%d%s", &m, a, &n, b);
	if (n<m)
	{
		puts("-1"); return 0;
	}
	preBmBc(a, m, bmBc);
	preBmGs(a, m, bmGs);
	int i, j=0, pos=-1;
	while (j<=n-m)
	{
		for (i=m-1; i>=0 && a[i]==b[j+i]; --i);
		if (i<0)
		{
			pos=j; break;
		}
		j+=max(m-1-bmGs[i], i-bmBc[b[j+i]]);
	}
	printf("%d\n", pos);
	return 0;
}


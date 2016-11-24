#include <cstdio>
const int Maxn=100002;
int p[Maxn];
char a[Maxn],b[Maxn];

int main()
{
	int m,n,i,j,ans;
	scanf("%d%s%d%s",&m,a,&n,b);
	p[0]=j=0;
	for (i=1; i<m; ++i)
	{
		while (j && a[i]!=a[j]) j=p[j-1];
		if (a[i]==a[j]) ++j;
		p[i]=j;
	}
	ans=j=0;
	for (i=0; i<n; ++i)
	{
		while (j && b[i]!=a[j]) j=p[j-1];
		if (b[i]==a[j]) ++j;
		if (j==m) ++ans, j=p[j-1];
	}
	printf("%d\n",ans);
	return 0;
}

#include <cstdio>
#include <algorithm>
using namespace std;
const int Maxn=100002;
int z[Maxn];
char a[Maxn],b[Maxn];

int main()
{
	int n,m,i,j,k,p,ans;
	scanf("%d%s%d%s",&m,a,&n,b);
	k=1; z[0]=m; p=0;
	for (i=1; i<m; ++i)
		if (z[i-k]<p-i+1) z[i]=z[i-k]; else
		{
			for (j=max(p-i+1,0); i+j<m && a[i+j]==a[j]; ++j);
			k=i; p=i+j-1; z[i]=j;
		}
	for (j=0; j<m && j<n && a[j]==b[j]; ++j);
	k=0; p=j-1;
	ans=j==m;
	for (i=1; i<n; ++i)
	{
		if (z[i-k]<p-i+1) j=z[i-k]; else
		{
			for (j=max(p-i+1,0); j<m && i+j<n && b[i+j]==a[j]; ++j);
			k=i; p=i+j-1;
		}
		if (j==m) ++ans;
	}
	printf("%d\n",ans);
	return 0;
}

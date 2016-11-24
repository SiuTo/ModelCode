//O(n)求最长回文串
#include <cstdio>
const int Maxn=220003;
char str[Maxn];
int l[Maxn];

int main()
{
	int n,i;
	scanf("%d",&n);
	n=n*2+1;
	str[0]=' ', str[n+1]='\0';
	for (i=1; i<=n; ++i)
		if (i&1) str[i]='#'; else
		do scanf("%c",str+i); while (str[i]<'a' || str[i]>'z');
	int j,k=1,p=1,ans=0;
	for (i=2; i<=n; ++i)
	{
		if (l[k*2-i]<p-i) l[i]=l[k*2-i]; else
		{
			for (j=p>i? p-i:0; str[i-j]==str[i+j]; ++j);
			l[i]=j-1; k=i; p=i+j-1;
		}
		if (l[i]>ans) ans=l[i];
	}
	printf("%d\n",ans);
	return 0;
}


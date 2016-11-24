#include <cstdio>
char str[200001];

int main()
{
	int n,i,j,k;
	scanf("%d%s",&n,str);
	for (i=0; i<n; ++i) str[n+i]=str[i];
	for (i=0,j=1; i<n && j<n;)
	{
		for (k=0; k+1<n; ++k)
			if (str[i+k]!=str[j+k]) break;
		if (str[i+k]<str[j+k]) j+=k+1; else i+=k+1;
		if (i==j) ++j;
	}
	if (j<n) i=j;
	for (k=0; k<n; ++k) putchar(str[i+k]);
	putchar('\n');
	return 0;
}


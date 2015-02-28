#include <cstdio>
#include <cstring>
typedef long long LL;
const int Maxnum=47000;
bool prime[Maxnum+1];
int num[5000],o[30];

void makelist()
{
	memset(prime,1,sizeof prime);
	int i,j;
	for (i=2; i*i<=Maxnum; ++i)
		if (prime[i])
			for (j=i*i; j<=Maxnum; j+=i) prime[j]=false;
	int m=0;
	for (i=2; i<=Maxnum; ++i)
		if (prime[i]) num[m++]=i;
}

int power(LL a,int n,int m)
{
	LL s=1;
	while (n)
	{
		if (n&1) s=s*a%m;
		n>>=1;
		a=a*a%m;
	}
	return s;
}

int main()
{
	int p,n,phi,x,i,k,r;
	makelist();
	scanf("%d%d",&p,&n);
	while (n)
	{
		phi=p-1;
		for (i=k=0,x=phi; num[i]<=x/num[i]; ++i)
			if (x%num[i]==0)
			{
				o[k++]=phi/num[i];
				while (x%num[i]==0) x/=num[i];
			}
		if (x>1) o[k++]=phi/x;
		while (n--)
		{
			scanf("%d",&r);
			for (i=0; i<k && power(r,o[i],p)!=1; ++i);
			if (i<k) puts("NO"); else puts("YES");
		}
		scanf("%d%d",&p,&n);
	}
	return 0;
}

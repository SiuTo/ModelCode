#include <cstdio>
#include <cstring>
const int Mod=2012, Maxn=100001;
char str[Maxn];
int m,tot,root,a[Maxn],o[Maxn*2],cnt[Maxn*2],sum[Maxn*2],into[Maxn*2];
struct Node
{
	int fa,val,next[11];
} t[Maxn*2];

void buildSAM()
{
	root=1, tot=1;
	int last=1, i,p,q,np,nq;
	memset(t,0,sizeof t);
	for (i=0; i<m; ++i)
	{
		p=last;
		np=++tot;
		t[np].val=t[p].val+1;
		while (p && t[p].next[a[i]]==0) t[p].next[a[i]]=np, p=t[p].fa;
		if (!p) t[np].fa=root; else
		{
			q=t[p].next[a[i]];
			if (t[p].val+1==t[q].val) t[np].fa=q; else
			{
				nq=++tot;
				memcpy(t[nq].next,t[q].next,sizeof t[q].next);
				t[nq].val=t[p].val+1;
				t[nq].fa=t[q].fa;
				t[q].fa=nq;
				t[np].fa=nq;
				while (p && t[p].next[a[i]]==q) t[p].next[a[i]]=nq, p=t[p].fa;
			}
		}
		last=np;
	}
}

int dp()
{
	memset(into,0,sizeof into);
	int q1=0, q2=1, i,j,v,x,ans=0;
	for (i=1; i<=tot; ++i)
		for (j=0; j<=10; ++j)
			if (t[i].next[j]) ++into[t[i].next[j]];
	o[0]=1;
	memset(sum,0,sizeof sum);
	memset(cnt,0,sizeof cnt);
	cnt[1]=1;
	while (q1<q2)
	{
		v=o[q1++];
		ans=(ans+sum[v])%Mod;
		for (i=0; i<=10; ++i)
		{
			x=t[v].next[i];
			if (!x) continue;
			--into[x];
			if (!into[x]) o[q2++]=x;
			if (v==1 && i==0 || i==10) continue;
			cnt[x]=(cnt[x]+cnt[v])%Mod;
			sum[x]=(sum[x]+sum[v]*10+cnt[v]*i)%Mod;
		}
	}
	return ans;
}

int main()
{
	int n;
	scanf("%d",&n)
	m=0;
	while (n--)
	{
		scanf("%s",str);
		for (int i=0; str[i]; ++i) a[m++]=str[i]-'0';
		a[m++]=10;
	}
	--m;
	buildSAM();
	printf("%d\n",dp());
	return 0;
}

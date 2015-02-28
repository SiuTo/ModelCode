#include <cstdio>
#include <algorithm>
using namespace std;
const int Maxn=200001;
struct Node {int l,r,s,f,sum;} t[Maxn];
int n,root,l[Maxn],r[Maxn],key[Maxn],fa[Maxn];

void update(int v)
{
	t[v].s=t[l[v]].s+t[r[v]].s+1;
	t[v].sum=t[l[v]].sum+t[r[v]].sum+key[v];
	t[v].l=max(t[l[v]].l,t[l[v]].sum+key[v]+max(0,t[r[v]].l));
	t[v].r=max(t[r[v]].r,t[r[v]].sum+key[v]+max(0,t[l[v]].r));
	t[v].f=max(max(t[l[v]].f,t[r[v]].f),max(0,t[l[v]].r)+key[v]+max(0,t[r[v]].l));
}

void l_rotate(int v)
{
	int k=fa[v];
	fa[v]=fa[k];
	if (fa[k])
	{
		if (k==l[fa[k]]) l[fa[k]]=v; else r[fa[k]]=v;
	}
	r[k]=l[v]; fa[l[v]]=k;
	l[v]=k; fa[k]=v;
	update(k); 
}

void r_rotate(int v)
{
	int k=fa[v];
	fa[v]=fa[k];
	if (fa[k])
	{
		if (k==l[fa[k]]) l[fa[k]]=v; else r[fa[k]]=v;
	}
	l[k]=r[v]; fa[r[v]]=k;
	r[v]=k; fa[k]=v;
	update(k); 
}

void splay(int x,int goal)
{
	int y,z;
	while (fa[x]!=goal)
	{
		y=fa[x]; z=fa[y];
		if (z==goal)
		{
			if (x==l[y]) r_rotate(x); else l_rotate(x);
		}else
		if (y==l[z])
		{
			if (x==l[y]) r_rotate(y); else l_rotate(x);
			r_rotate(x);
		}else
		{
			if (x==r[y]) l_rotate(y); else r_rotate(x);
			l_rotate(x);
		}
	}
	update(x);
	if (!goal) root=x;
}

void init()
{
	scanf("%d",&n);
	t[0].l=t[0].r=t[0].f=-1000000000;
	fa[1]=2; update(1);
	for (int i=2; i<=n+1; ++i)
	{
		scanf("%d",key+i);
		fa[i]=i+1; l[i]=i-1;
		update(i);
	}
	n+=2;
	root=n; l[n]=n-1; update(root);
}

int getkth(int k)
{
	int v=root;
	while (k!=t[l[v]].s+1)
		if (k<=t[l[v]].s) v=l[v];
		else k-=t[l[v]].s+1, v=r[v];
	return v;
}

void insert(int p,int num)
{
	splay(getkth(p),0);
	int v=getkth(p-1);
	splay(v,root);
	r[v]=++n;
	fa[n]=v; t[n].s=1; key[n]=t[n].sum=t[n].l=t[n].r=t[n].f=num;
	update(v); update(root);
}

int divide(int x,int y)
{
	splay(getkth(x-1),0);
	int v=getkth(y+1);
	splay(v,root);
	return l[v];
}

int main()
{
	init();
	int m,x,y;
	scanf("%d",&m);
	char ch;
	while (m--)
	{
		do {scanf("%c",&ch);} while (ch!='I' && ch!='D' && ch!='R' && ch!='Q');
		scanf("%d",&x); ++x;
		switch (ch)
		{
			case 'D':x=divide(x,x); l[fa[x]]=0; update(fa[x]); update(root); break;
			case 'I':scanf("%d",&y); insert(x,y); break;
			case 'R':scanf("%d",&y); x=getkth(x); splay(x,0); key[x]=y; update(x); break;
			case 'Q':scanf("%d",&y); printf("%d\n",t[divide(x,++y)].f);
		}
	}
	return 0;
}

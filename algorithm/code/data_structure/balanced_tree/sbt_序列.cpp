//spoj gss6
#include <cstdio>
#include <algorithm>
using namespace std;
const int Maxn=200001;
struct Node {int l,r,s,f,sum;} t[Maxn];
int tot,l[Maxn],r[Maxn],key[Maxn];

void update(Node &a,Node &b,Node &c,int x)
{
	a.s=b.s+c.s+1;
	a.sum=b.sum+c.sum+x;
	a.l=max(b.l,b.sum+x+max(0,c.l));
	a.r=max(c.r,c.sum+x+max(0,b.r));
	a.f=max(max(b.f,c.f),max(0,b.r)+x+max(0,c.l));
}

void l_rotate(int &v)
{
	int k=r[v];
	r[v]=l[k];
	l[k]=v;
	t[k]=t[v];
	update(t[v],t[l[v]],t[r[v]],key[v]);
	v=k;
}

void r_rotate(int &v)
{
	int k=l[v];
	l[v]=r[k];
	r[k]=v;
	t[k]=t[v];
	update(t[v],t[l[v]],t[r[v]],key[v]);
	v=k;
}

void insert(int &v,int x,int y)
{
	if (!v)
	{
		v=++tot; l[v]=r[v]=0; t[v].s=1; t[v].l=t[v].r=t[v].f=t[v].sum=key[v]=y; return;
	}
	if (x<=t[l[v]].s+1)
	{
		insert(l[v],x,y);
		update(t[v],t[l[v]],t[r[v]],key[v]);
		if (t[l[l[v]]].s>t[r[v]].s) r_rotate(v);
	}else
	{
		insert(r[v],x-t[l[v]].s-1,y);
		update(t[v],t[l[v]],t[r[v]],key[v]);
		if (t[r[r[v]]].s>t[l[v]].s) l_rotate(v);
	}
}

void replace(int v,int x,int y)
{
	if (x==t[l[v]].s+1)
	{
		key[v]=y; update(t[v],t[l[v]],t[r[v]],y); return;
	}
	if (x<t[l[v]].s+1) replace(l[v],x,y); else replace(r[v],x-t[l[v]].s-1,y);
	update(t[v],t[l[v]],t[r[v]],key[v]);
}

int del(int &v,int x)
{
	int tmp;
	if (x==t[l[v]].s+1)
	{
		if (l[v] && r[v])
		{
			key[v]=del(l[v],x-1);
			update(t[v],t[l[v]],t[r[v]],key[v]);
			return 0;
		}
		tmp=key[v]; v=l[v]+r[v];
		return tmp;
	}
	if (x<t[l[v]].s+1) tmp=del(l[v],x); else tmp=del(r[v],x-t[l[v]].s-1);
	update(t[v],t[l[v]],t[r[v]],key[v]);
	return tmp;
}

Node query(int v,int x,int y)
{
	if (x>y) return t[0];
	if (x==1 && y==t[v].s) return t[v];
	int mid=t[l[v]].s+1;
	if (y<mid) return query(l[v],x,y);
	if (x>mid) return query(r[v],x-mid,y-mid);
	Node tt, tl=query(l[v],x,mid-1), tr=query(r[v],1,y-mid);
	update(tt,tl,tr,key[v]);
	return tt;
}

int main()
{
	int n,m,i,x,y,root=0;
	scanf("%d",&n);
	tot=0;
	t[0].l=t[0].r=t[0].f=-1000000000;
	for (i=1; i<=n; ++i)
	{
		scanf("%d",&x);
		insert(root,i,x);
	}
	scanf("%d",&m);
	char ch;
	while (m--)
	{
		do {scanf("%c",&ch);} while (ch!='I' && ch!='D' && ch!='R' && ch!='Q');
		scanf("%d",&x);
		switch (ch)
		{
			case 'D':del(root,x); break;
			case 'I':scanf("%d",&y); insert(root,x,y); break;
			case 'R':scanf("%d",&y); replace(root,x,y); break;
			case 'Q':scanf("%d",&y); printf("%d\n",query(root,x,y).f);
		}
	}
	return 0;
}
